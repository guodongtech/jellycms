<?php
namespace CodeIgniter\View;
use CodeIgniter\View\Exceptions\ViewException;
use Config\Services;
use Psr\Log\LoggerInterface;

/**
 * Class View
 *
 * @package CodeIgniter\View
 */
class View implements RendererInterface
{

	/**
	 * Data that is made available to the Views.
	 *
	 * @var array
	 */
	protected $data = [];

	/**
	 * The base directory to look in for our Views.
	 *
	 * @var string
	 */
	protected $viewPath;

	/**
	 * The render variables
	 *
	 * @var array
	 */
	protected $renderVars = [];

	/**
	 * Instance of FileLocator for when
	 * we need to attempt to find a view
	 * that's not in standard place.
	 *
	 * @var \CodeIgniter\Autoloader\FileLocator
	 */
	protected $loader;

	/**
	 * Logger instance.
	 *
	 * @var \CodeIgniter\Log\Logger
	 */
	protected $logger;

	/**
	 * Should we store performance info?
	 *
	 * @var boolean
	 */
	protected $debug = false;

	/**
	 * Cache stats about our performance here,
	 * when CI_DEBUG = true
	 *
	 * @var array
	 */
	protected $performanceData = [];

	/**
	 * @var \Config\View
	 */
	protected $config;

	/**
	 * Whether data should be saved between renders.
	 *
	 * @var boolean
	 */
	protected $saveData;

	/**
	 * Number of loaded views
	 *
	 * @var integer
	 */
	protected $viewsCount = 0;

	/**
	 * The name of the layout being used, if any.
	 * Set by the `extend` method used within views.
	 *
	 * @var string
	 */
	protected $layout;

	/**
	 * Holds the sections and their data.
	 *
	 * @var array
	 */
	protected $sections = [];

	/**
	 * The name of the current section being rendered,
	 * if any.
	 *
	 * @var string
	 */
	protected $currentSection;
	private static $queryExcept = array('name','id','items','item','key');
	//--------------------------------------------------------------------

	/**
	 * Constructor
	 *
	 * @param \Config\View    $config
	 * @param string          $viewPath
	 * @param mixed           $loader
	 * @param boolean         $debug
	 * @param LoggerInterface $logger
	 */
	public function __construct($config, string $viewPath = null, $loader = null, bool $debug = null, LoggerInterface $logger = null)
	{
		$this->config   = $config;
		$this->viewPath = rtrim($viewPath, '/ ') . '/';
		$this->loader   = is_null($loader) ? Services::locator() : $loader;
		$this->logger   = is_null($logger) ? Services::logger() : $logger;
		$this->debug    = is_null($debug) ? CI_DEBUG : $debug;
		$this->saveData = $config->saveData ?? null;
	}

	//--------------------------------------------------------------------

	/**
	 * Builds the output based upon a file name and any
	 * data that has already been set.
	 *
	 * Valid $options:
	 *     - cache 		number of seconds to cache for
	 *  - cache_name	Name to use for cache
	 *
	 * @param string  $view
	 * @param array   $options
	 * @param boolean $saveData
	 *
	 * @return string
	 */
	public function render(string $view, array $options = null, bool $saveData = null): string
	{
		$this->renderVars['start'] = microtime(true);

		// Store the results here so even if
		// multiple views are called in a view, it won't
		// clean it unless we mean it to.
		if ($saveData !== null)
		{
			$this->saveData = $saveData;
		}

		$fileExt                     = pathinfo($view, PATHINFO_EXTENSION);
		$realPath                    = empty($fileExt) ? $view . '.php' : $view; // allow Views as .html, .tpl, etc (from CI3)
		$this->renderVars['view']    = $realPath;
		$this->renderVars['options'] = $options;
		//只对 home 生效
		if(defined('AUTHTHEME')){
			//拼接模板路径
			$this->viewPath = $this->viewPath.$options['theme'].'/'.$options['folder'].'/';
			$this->viewDirectory = $this->viewDirectory.$options['theme'];
		}else{
			$this->viewDirectory = $this->viewDirectory;
		}
		// Was it cached?
		if (isset($this->renderVars['options']['cache']))
		{
			$this->renderVars['cacheName'] = $this->renderVars['options']['cache_name'] ?? str_replace('.php', '', $this->renderVars['view']);
			if ($output = cache($this->renderVars['cacheName']))
			{
				$this->logPerformance($this->renderVars['start'], microtime(true), $this->renderVars['view']);
				return $output;
			}
		}

		$this->renderVars['file'] = $this->viewPath . $this->renderVars['view'];

		if (! is_file($this->renderVars['file']))
		{
			$this->renderVars['file'] = $this->loader->locateFile($this->renderVars['view'], 'Views', empty($fileExt) ? 'php' : $fileExt);
		}

		// locateFile will return an empty string if the file cannot be found.
		if (empty($this->renderVars['file']))
		{
			exit('模板不存在：'.$this->renderVars['view']);
		}

		// Make our view data available to the view.
		extract($this->data);

		if (! $this->saveData)
		{
			$this->data = [];
		}
		//解析标签
		$template = file_get_contents($this->renderVars['file']);
		$start = microtime(true);
		$output = $this->resolve($template);
 		$end = microtime(true);
		//echo number_format($end-$start, 4);//正则匹配的时间 本地7ms左右

		ob_start();
		//include($this->renderVars['file']); // PHP will be processed
		$incoming = '?>' . $output;
		eval($incoming);// PHP will be processed
		$output = ob_get_contents();
		@ob_end_clean();

		// When using layouts, the data has already been stored
		// in $this->sections, and no other valid output
		// is allowed in $output so we'll overwrite it.
		if (! is_null($this->layout) && empty($this->currentSection))
		{
			$layoutView   = $this->layout;
			$this->layout = null;
			$output       = $this->render($layoutView, $options, $saveData);
		}

		$this->logPerformance($this->renderVars['start'], microtime(true), $this->renderVars['view']);

		if ($this->debug && (! isset($options['debug']) || $options['debug'] === true))
		{
			$toolbarCollectors = config(\Config\Toolbar::class)->collectors;

			if (in_array(\CodeIgniter\Debug\Toolbar\Collectors\Views::class, $toolbarCollectors))
			{
				// Clean up our path names to make them a little cleaner
				foreach (['APPPATH', 'SYSTEMPATH', 'ROOTPATH'] as $path)
				{
					if (strpos($this->renderVars['file'], constant($path)) === 0)
					{
						$this->renderVars['file'] = str_replace(constant($path), $path . '/', $this->renderVars['file']);
						break;
					}
				}
				$this->renderVars['file'] = ++$this->viewsCount . ' ' . $this->renderVars['file'];
				$output                   = '<!-- DEBUG-VIEW START ' . $this->renderVars['file'] . ' -->' . PHP_EOL
					. $output . PHP_EOL
					. '<!-- DEBUG-VIEW ENDED ' . $this->renderVars['file'] . ' -->' . PHP_EOL;
			}
		}
		// Should we cache?
		if (isset($this->renderVars['options']['cache']))
		{
			cache()->save($this->renderVars['cacheName'], $output, (int) $this->renderVars['options']['cache']);
		}

		return $output;
	}
    /**
     * @brief  解析给定的字符串
     * @param string $str 要解析的字符串
     * @return String 解析处理的字符串
     */
	public function resolve($str)
	{
		//优先处理include标签 为防止死循环，最多调用10层
		for($i=0; preg_match('/{(\/?)(include)\s*(:?)([^}]*)}/i', $str, $matches); $i++){
			$str = preg_replace_callback('/{(\/?)(include)\s*(:?)([^}]*)}/i', array($this,'translate'), $str); 
			if($i>10){ //防止死循环
				exit('模板include使用超过10层嵌套，可能已产生死循环.请检查模板调用!');
				break;
			}
		}
		//处理闭合类标签里的参数
		$closedTag = "form|foreach|if|elseif|else|while|for|content|list|nav|slide|position|pagebar|link|pics|sort";
		$closed = explode('|', $closedTag);
		foreach($closed as $key=>$value){

			$startTag= '\{('.$value.'):';
			$endTag = '\{\/'.$value.'\}';
			$reg="/{$startTag}([^}]+)?\}(?:(?>[\s\S]*?(?={?:$startTag}|{$endTag}))|(?R))*{$endTag}/ui"; 
			$str = preg_replace_callback($reg, array($this,'parseParams'), $str); //匹配闭合标签体中参数 参数类似[list:title len=8]
		}
		//echo $str;
/* 		if(preg_match('/{(\/?)(list)\s*(:?)([^}]*)}/i', $str, $matches)){ //处理pagebar任意位置问题，三处优先处理顺序不能变
			$attr = $this->getAttrs($matches[4]);
			isset($attr['id'])? $id=$attr['id']:$id = '$sort["id"]';
			unset($attr['id']);
			//实现属性中符号表达式的问题
			$old_char=array(' eq ',' l ',' g ',' le ',' ge ', ' neq ');
			$new_char=array(' = ' ,' < ',' > ',' <= ',' >= ', ' !=  ');
			foreach($attr as $k => $v)
			{
				if(!in_array($k,self::$queryExcept))
				{
					$v    = preg_replace('%(\$\w+\->\w+\[[\'|\"]\w+[\'|\"]\])%','{$1}',$v);//对变量处理增加花括号
					$tem .= '"'.$k.'"=>"'.str_replace($old_char,$new_char,$v).'",';
				}
			}
			$params = '['.trim($tem, ',').']';
			$str = '<?php if(!isset($model)) $model = new \App\Models\ParseModel(); $data_ = $model->getList(array('.$id.'),'.$params.',$page); $pagebar = $data_["pagebar"]; ?>'.$str;
		} */
		//前面已完成中间解析，正式解析标签
		return preg_replace_callback('/{(\/?)(\$|include|theme|webroot|url|echo|widget|formaction|form|foreach|set|sorts|contents|require|if|elseif|else|while|for|js|content|list|nav|slide|position|pagebar|link|label|pics|sort|site|company|statistics|myad|pre|next)\s*(:?)([^}]*)}/i', array($this,'translate'), $str);
	}
    /**
     * @brief 替换循环标签里的变量 如：{nav: pid=[nav:id]}
     * @param array $matches
     * @return String 直接PHP变量值$nav['id']
     */
	public function parseTagParams($matches){
		//print_r($matches);
		if(preg_match_all('/\[(([\w]+)):([\w]+)(\s+[^]]+)?\]/', $matches[0], $matchesP)){
			foreach($matchesP[0] as $key=>$value){
				$paramTemp = str_replace(array('[', ':' , ']'), array('$', '["', '"]'), $value);
				$matches[0] = str_replace($value, $paramTemp, $matches[0]);
			}
		}
		return $matches[0];
	}
    /**
     * @brief 替换循环标签内变量 如：[sort:id]
     * @param array $matches
     * @return String 中间结果
     */
	public function parseParams($matches){
		//print_r($matches);
		//匹配带参数的标签（主要用在无限类标签）  参数类似[nav:name] 参数里不能再带参数如[nav:name len=9]
		$matches[0] = preg_replace_callback('/\{('.$matches[1].'):([^}]+)?\}?/ui', array($this,'parseTagParams'), $matches[0]);
		if(preg_match_all('/\[[\w]+:(?:[\w]+)(?:\s+[^]]+)?\]/', $matches[0], $matchesP)){
			foreach($matchesP[0] as $key=>$value){
				$paramTemp = $value;
				if(strpos($paramTemp, '[') !== false){
					$paramTemp = substr_replace($paramTemp,'{$',strpos($paramTemp, '['), 1); //[第一次出现
				}
				if(strpos($paramTemp, ':') !== false){
					$paramTemp = substr_replace($paramTemp,".",strpos($paramTemp, ':'),1); //:第一次出现
				}
				if(strpos( $paramTemp, ']') !== false){
					$paramTemp = substr_replace($paramTemp,"}",strrpos($paramTemp, ']'), 1); //]最后一次出现
				}
				$matches[0] = str_replace($value, $paramTemp, $matches[0]);
			}
		}
		return $matches[0];
	}

    /**
     * @brief 处理设定的每一个标签
     * @param array $matches
     * @return String php代码
     */
	public function translate($matches)
	{
		if($matches[1]!=='/')
		{
			switch($matches[2].$matches[3])
			{
				case '$':
                {
					$arr = explode(' ', $matches[4]);
					$str = trim($arr[0]);
					$attr = $this->getAttrs($matches[4]);
					//isset($attr['len'])? $len=$attr['len']:$len = 'mb_strlen($'.str_replace(".",'["',$str).'"],"utf-8")';
					isset($attr['len'])? $len=$attr['len']:$len = 0;//未设置则不对字符串进行截取处理
					isset($attr['strip'])? $strip=$attr['strip']:$strip = 1; //默认去掉HTML标签
					isset($attr['style'])? $style=$attr['style']:$style = 'Y-m-d h:i'; //默认时间样式
                    $first = $str[0];
					if($first != '.' && $first != '(')
					{
						if( strpos($str,'(') !== false || (strpos($str,'[') === false && strpos($str,'->') !== false) )
						{
							return '<?php echo $'.$str.';?>';
							
						}else if(strpos($str,'.') !== false)//所有循环标签转换标签为类似{sorts:title len=10 style=Y-m-d strip=1},只需在此处理参数
						{
							if(isset($attr['len']) || isset($attr['strip'])){
								
								return '<?php echo strTreat($'.str_replace(".",'["',$str).'"],'."$len,$strip);?>";
							}else if(isset($attr['style'])){
								return '<?php echo date("'.$style.'",strtotime($'.str_replace(".",'["',$str).'"]));?>';
							}else{
								return '<?php echo $'.str_replace(".",'["',$str).'"];?>';
							}
						}
						else
						{
							return '<?php echo isset($'.$str.')?$'.$str.':"";?>';
						}
					}
                    else return $matches[0];
                }
				case 'require:':
				case 'include:':
				{
					$fileName = trim($matches[4],"/ ");
					if (!is_file($this->viewPath.$fileName))
					{
						exit('模板不存在：'.$fileName);
					}
					$file = file_get_contents($this->viewPath.$fileName);
					
					return $file;

				}
				case 'echo:': return '<?php echo '.rtrim($matches[4],';/').';?>';
				//无限嵌套FORM
				case 'form:': 
				{
					$attr = $this->getAttrs($matches[4]);
					isset($attr['pid'])? $pid=$attr['pid']:$pid = 0;
					isset($attr['id'])? $id=$attr['id']:$id = '$sorts["id"]';
					isset($attr['value'])? $value=$attr['value']:$value = 'form';
					isset($attr['num'])? $num=$attr['num']:$id = 5;//默认5条
					return  '<?php if(!isset($model)) $model = new \App\Models\ParseModel(); $data_=$model->getFormlistByFromName('.$id.',"'.$attr['name'].'",$contents["id"],$pid = '.$pid.', $num='.$num.',$page); $pagebar=$data_["pagebar"];foreach($data_["data"] as $key=>$'.$value.'){?>';
				}
				case 'formaction:': 
				{
					$attr = $this->getAttrs($matches[4]);
					return '<?php echo "/'.$GLOBALS['self_path'].'".ENTRANCE."/form/index/"."'.$attr['name'].'" ;?>';
				}
				case 'url:':
				{
					$matches[4] = $this->varReplace($matches[4]);
					return $this->Url($matches[4]);
				}
                case 'webroot:':
                {
                	return '<?php echo "'.$GLOBALS['self_path'].'/'.$matches[4].'";?>';
                }
				case 'theme:': 
				{
					$config = new \Config\Config();
					return '<?php echo "'.$GLOBALS['self_path'].'/'.$GLOBALS['homeViewName'].'/'.$this->renderVars['options']['theme'].'/'.$matches[4].'";?>';
				}
                case 'company:':
                {
                	return '<?php echo $company["'.$matches[4].'"];?>';
                }
                case 'site:':
                {
                	return '<?php echo $site["'.$matches[4].'"];?>';
                }
                case 'sorts:':
                {
					$arr = explode(' ', $matches[4]);
					$str = trim($arr[0]);
					$attr = $this->getAttrs($matches[4]);
					if(isset($attr['style'])){
						return '<?php echo date("'.$attr['style'].'",strtotime($sorts["'.str_replace(".",'["',$str).'"]));?>';
					}else{
						return '<?php echo $sorts["'.$matches[4].'"];?>';
					}
                }
                case 'contents:':
                {
					$arr = explode(' ', $matches[4]);
					$str = trim($arr[0]);
					$attr = $this->getAttrs($matches[4]);
					if(isset($attr['style'])){
						return '<?php echo date("'.$attr['style'].'",strtotime($contents["'.str_replace(".",'["',$str).'"]));?>';
					}else{
						return '<?php echo $contents["'.$matches[4].'"];?>';
					}
                }
                case 'label:':
                {
					$arr = explode(' ', $matches[4]);
					$str = trim($arr[0]);
					$attr = $this->getAttrs($matches[4]);
					isset($attr['value'])? $value=$attr['value']:$value = 'value';
					return '<?php if(!isset($model))  $model = new \App\Models\ParseModel(); echo $model->getLabel("'.$str.'", "'.$value.'")?>';
                }
				case 'if:': return '<?php if('.$matches[4].'){?>';
				case 'elseif:': return '<?php }elseif('.$matches[4].'){?>';
				case 'else:': return '<?php }else{'.$matches[4].'?>';
				case 'set:':
                {
                    return '<?php '.$matches[4].'?>';
                }
				case 'while:': return '<?php while('.$matches[4].'){?>';
				case 'foreach:':
				{
					$attr = $this->getAttrs($matches[4]);
					if(!isset($attr['items'])) $attr['items'] = '$items';
					else $attr['items'] = '$items='.$attr['items'];
					if(!isset($attr['key'])) $attr['key'] = '$key';
					else $attr['key'] = $attr['key'];
					if(!isset($attr['item'])) $attr['item'] = '$item';
					else $attr['item'] = $attr['item'];

					return '<?php foreach('.$attr['items'].' as '.$attr['key'].' => '.$attr['item'].'){?>';
				}
				case 'for:':
				{
					$attr = $this->getAttrs($matches[4]);
					if(!isset($attr['item'])) $attr['item'] = '$i';
					else $attr['item'] = $attr['item'];
					if(!isset($attr['from'])) $attr['from'] = 0;

                    if(!isset($attr['upto']) && !isset($attr['downto'])) $attr['upto'] = 10;
                    if(isset($attr['upto']))
                    {
                        $op = '<=';
                        $end = $attr['upto'];
                        if($attr['upto']<$attr['from']) $attr['upto'] = $attr['from'];
                        if(!isset($attr['step'])) $attr['step'] = 1;
                    }
                    else
                    {
                        $op = '>=';
                        $end = $attr['downto'];
                        if($attr['downto']>$attr['from'])$attr['downto'] = $attr['from'];
                        if(!isset($attr['step'])) $attr['step'] = -1;
                    }
					return '<?php for('.$attr['item'].' = '.$attr['from'].' ; '.$attr['item'].$op.$end.' ; '.$attr['item'].' = '.$attr['item'].'+'.$attr['step'].'){?>';
				}
				case 'query:':
				{
					$endchart=substr(trim($matches[4]),-1);
					$attrs = $this->getAttrs(rtrim($matches[4],'/'));
                    if(!isset($attrs['id']))
                    {
                    	$id = '$query';
                    }
                    else
                    {
                    	$id = $attrs['id'];
                    }

                    if(!isset($attrs['items']))
                    {
                    	$items = '$items';
                    }
                    else
                    {
                    	$items = $attrs['items'];
                    }
					$tem = "$id".' = $this->db->table('.$attrs['name'].');';
					//实现属性中符号表达式的问题
					$old_char=array(' eq ',' l ',' g ',' le ',' ge ', ' neq ');
					$new_char=array(' = ' ,' < ',' > ',' <= ',' >= ', ' !=  ');
					foreach($attrs as $k => $v)
					{
						if(!in_array($k,self::$queryExcept))
						{
							$v    = preg_replace('%(\$\w+\->\w+\[[\'|\"]\w+[\'|\"]\])%','{$1}',$v);//对变量处理增加花括号
							$tem .= "{$id}->".$k.'('.str_replace($old_char,$new_char,$v).');';
						}
					}
					$tem .= $items.' = '.$id.'->get()->getResultArray();';
					if(!isset($attrs['key']))
					{
						$attrs['key'] = '$key';
					}
					else
					{
						$attrs['key'] = $attrs['key'];
					}
					if(!isset($attrs['item']))
					{
						$attrs['item'] = '$item';
					}
					else
					{
						$attrs['item'] = $attrs['item'];
					}
					if($endchart=='/')
					{
						return '<?php '.$tem.'?>';
					}
					else
					{
						return '<?php '.$tem.' foreach('.$items.' as '.$attrs['key'].' => '.$attrs['item'].'){?>';
					}
				}

				case 'content:': 
				{
					$attr = $this->getAttrs($matches[4]);
					if(isset($attr['id'])) $id = $attr['id']; else $id = '$contents["id"]'; 
					return '<?php if(!isset($model)) $model = new \App\Models\ParseModel(); foreach(array($model->getContent('.$id.')) as $key=>$content){?>';
				}
				case 'sort:': 
				{
					$attr = $this->getAttrs($matches[4]);
					if(isset($attr['id'])) $id = $attr['id'];
					return '<?php if(!isset($model)) $model = new \App\Models\ParseModel();  foreach(array($model->getSort('.$id.')) as $key=>$sort){?>';
				}
				case 'position:': 
				{
					return '<?php if(!isset($model)) $model = new \App\Models\ParseModel(); foreach($model->getPosition($sorts["id"]) as $key=>$position){?>';
				}
				//可指定多个ID id=1,2,3,4
				case 'list:':
				{
					$attr = $this->getAttrs($matches[4]);
					isset($attr['id'])? $id=$attr['id']:$id = '$sorts["id"]';
					unset($attr['id']);
					//实现属性中符号表达式的问题
					$old_char=array(' eq ',' l ',' g ',' le ',' ge ', ' neq ');
					$new_char=array(' = ' ,' < ',' > ',' <= ',' >= ', ' !=  ');
					foreach($attr as $k => $v)
					{
						if(!in_array($k,self::$queryExcept))
						{
							$v    = preg_replace('%(\$\w+\->\w+\[[\'|\"]\w+[\'|\"]\])%','{$1}',$v);//对变量处理增加花括号
							$tem .= '"'.$k.'"=>"'.str_replace($old_char,$new_char,$v).'",';
						}
					}
					$params = '['.trim($tem, ',').']';
					return '<?php if(!isset($model)) $model = new \App\Models\ParseModel(); $data_ = $model->getList(array('.$id.'),'.$params.',$page); $pagebar = $data_["pagebar"]; foreach($data_["data"] as $key=>$list){?>';
				}
				case 'pagebar:':
				{
					$key = trim($matches[4],"/ ");
					return '<?php echo $pagebar["'.$key.'"]  ?>';
				}
				//无限嵌套 可指定多个pid=1,2,3,4
				case 'nav:':
				{
					$attr = $this->getAttrs($matches[4]);
					if(isset($attr['pid'])) $pid = $attr['pid'];
					else $pid = 0;
					if(!isset($attr['key'])) $attr['key'] = '$key';
					else $attr['key'] = $attr['key'];
					
					isset($attr['value'])? $value=$attr['value']:$value = 'nav';
					isset($attr['num'])? $num=$attr['num']:$num = 100;//如果没设置就显示100
					return '<?php if(!isset($model)) $model = new \App\Models\ParseModel(); foreach($model->getSortByPid(array('.$pid.'),$num='.$num.') as '.$attr['key'].' => $'.$value.'){?>';
				}
				case 'slide:':
				{
					$attr = $this->getAttrs($matches[4]);
					isset($attr['num'])? $num=$attr['num']:$num = 100;//如果没设置就显示100
					if(isset($attr['gid'])) $gid = $attr['gid'];
					else $gid = 0; //不设置分组ID,则读当前区域第一个可用分组
					return '<?php if(!isset($model)) $model = new \App\Models\ParseModel(); foreach($model->getSlide('.$gid.', $num='.$num.') as $key=>$slide){?>';
				}
				case 'link:':
				{
					$attr = $this->getAttrs($matches[4]);
					isset($attr['num'])? $num=$attr['num']:$num = 100;//如果没设置就显示100
					if(isset($attr['gid'])) $gid = $attr['gid'];
					else $gid = 0; //不设置分组ID,则读当前区域第一个可用分组
					return '<?php if(!isset($model)) $model = new \App\Models\ParseModel(); foreach($model->getLink('.$gid.', $num='.$num.') as $key=>$link){?>';
				}
				case 'pics:':
				{
					$attr = $this->getAttrs($matches[4]);
					isset($attr['num'])? $num=$attr['num']:$num = 100;//如果没设置就显示100
					isset($attr['from'])? $from=$attr['from']:$from = 'content';
					if(isset($attr['id'])){
						$id = $attr['id'];
					}else if($from == 'content'){
						$id = '$content["id"]';
					}else if($from == 'sort'){
						$id = '$sort["id"]';
					}
					return '<?php if(!isset($model)) $model = new \App\Models\ParseModel(); foreach($model->getPics('.$id.', $num='.$num.',"'.$from.'") as $key=>$pics){?>';
				}
				case 'statistics:':
				{
					$sorts_id = '<?php echo $sorts["id"]>0?$sorts["id"]:0; ?>';
					$content_id = '<?php echo $contents["id"]>0?$contents["id"]:0; ?>';
					$str = '<script src="/index.php/Statistics/index/'.$sorts_id.'/'.$content_id.'"></script>';
					return $str;
				}
				case 'myad:':
                {
					$arr = explode(' ', $matches[4]);
					$str = trim($arr[0]);
					return '<?php if(!isset($model))  $model = new \App\Models\ParseModel(); echo $model->getNormbody("'.$str.'"); ?>';
                }
                case 'pre:':
				{
					$arr = explode(' ', $matches[4]);
					$str = trim($arr[0]);
					return '<?php  echo $pre["'.$str.'"]; ?>';
				}
				case 'next:':
				{
					return '<?php  echo $next["'.$str.'"]; ?>';
				}
				default:
				{
					 return $matches[0];
				}
			}
		}
		else
		{
/* 			if($matches[2]){
				//这两个标签在列表页或内容页有同名数组，会覆盖$content $sort的值。此处还原之前的数组  此问题已处理，但此处保留，用于重名数据参考
				switch($matches[2]){
					case 'content':
					{
						return '<?php } $content = $contentTemp; ?>';
					}
					case 'sort':
					{
						return '<?php } $sort = $sortTemp; ?>';
					}
					default:
					{
						return '<?php }?>';
					}
				}
			}else{
				return '<?php }?>';
			} */
			
			return '<?php }?>';
		}
	}
	
	
	
    /**
     * @brief URL生成
     * @param string $str
     * @return string 
     */
	public function Url($str)
	{	
		$url = $GLOBALS['self_path'].'/'.ADMINNAME.$str;
		return $url;
	}
    /**
     * @brief 分析标签属性
     * @param string $str
     * @return array以数组的形式返回属性值
     */
	public function getAttrs($str)
	{
		$str = strtr($str,array("=>" => "^^"));
		preg_match_all('/\w+\s*=(?:[^=]+?)(?=(\S+\s*=)|$)/i', trim($str), $attrs);
		$attr = array();
		foreach($attrs[0] as $value)
		{
			$tem = explode('=',$value);
			$attr[trim($tem[0])] = trim(strtr($tem[1],array("^^" => "=>")));
		}
		return $attr;
	}

    /**
     * @brief 变量替换操作
     * @param string $str
     * @return string
     */
	public function varReplace($str)
	{
		return preg_replace(array("#(\\$.*?(?=$|\/))#","#(\\$\w+)\[(\w+)\]#"),array("\".$1.\"","$1['$2']"),$str);
	}
	//--------------------------------------------------------------------

	/**
	 * Builds the output based upon a string and any
	 * data that has already been set.
	 * Cache does not apply, because there is no "key".
	 *
	 * @param string  $view     The view contents
	 * @param array   $options  Reserved for 3rd-party uses since
	 *                          it might be needed to pass additional info
	 *                          to other template engines.
	 * @param boolean $saveData If true, will save data for use with any other calls,
	 *                          if false, will clean the data after displaying the view,
	 *                             if not specified, use the config setting.
	 *
	 * @return string
	 */
	public function renderString(string $view, array $options = null, bool $saveData = null): string
	{
		$start = microtime(true);
		if (is_null($saveData))
		{
			$saveData = $this->config->saveData;
		}

		extract($this->data);

		if (! $saveData)
		{
			$this->data = [];
		}

		ob_start();
		$incoming = '?>' . $view;
		eval($incoming);
		$output = ob_get_contents();
		@ob_end_clean();

		$this->logPerformance($start, microtime(true), $this->excerpt($view));

		return $output;
	}

	//--------------------------------------------------------------------

	/**
	 * Extract first bit of a long string and add ellipsis
	 *
	 * @param  string  $string
	 * @param  integer $length
	 * @return string
	 */
	public function excerpt(string $string, int $length = 20): string
	{
		return (strlen($string) > $length) ? substr($string, 0, $length - 3) . '...' : $string;
	}

	//--------------------------------------------------------------------

	/**
	 * Sets several pieces of view data at once.
	 *
	 * @param array  $data
	 * @param string $context The context to escape it for: html, css, js, url
	 *                        If null, no escaping will happen
	 *
	 * @return RendererInterface
	 */
	public function setData(array $data = [], string $context = null): RendererInterface
	{
		if (! empty($context))
		{
			$data = \esc($data, $context);
		}
		$this->data = array_merge($this->data, $data);

		return $this;
	}

	//--------------------------------------------------------------------

	/**
	 * Sets a single piece of view data.
	 *
	 * @param string $name
	 * @param mixed  $value
	 * @param string $context The context to escape it for: html, css, js, url
	 *                        If null, no escaping will happen
	 *
	 * @return RendererInterface
	 */
	public function setVar(string $name, $value = null, string $context = null): RendererInterface
	{
		if (! empty($context))
		{
			$value = \esc($value, $context);
		}

		$this->data[$name] = $value;

		return $this;
	}

	//--------------------------------------------------------------------

	/**
	 * Removes all of the view data from the system.
	 *
	 * @return RendererInterface
	 */
	public function resetData(): RendererInterface
	{
		$this->data = [];

		return $this;
	}

	//--------------------------------------------------------------------

	/**
	 * Returns the current data that will be displayed in the view.
	 *
	 * @return array
	 */
	public function getData(): array
	{
		return $this->data;
	}

	//--------------------------------------------------------------------

	/**
	 * Specifies that the current view should extend an existing layout.
	 *
	 * @param string $layout
	 *
	 * @return void
	 */
	public function extend(string $layout)
	{
		$this->layout = $layout;
	}

	//--------------------------------------------------------------------

	/**
	 * Starts holds content for a section within the layout.
	 *
	 * @param string $name
	 */
	public function section(string $name)
	{
		$this->currentSection = $name;

		ob_start();
	}

	//--------------------------------------------------------------------

	/**
	 *
	 *
	 * @throws \Laminas\Escaper\Exception\RuntimeException
	 */
	public function endSection()
	{
		$contents = ob_get_clean();

		if (empty($this->currentSection))
		{
			throw new \RuntimeException('View themes, no current section.');
		}

		// Ensure an array exists so we can store multiple entries for this.
		if (! array_key_exists($this->currentSection, $this->sections))
		{
			$this->sections[$this->currentSection] = [];
		}
		$this->sections[$this->currentSection][] = $contents;

		$this->currentSection = null;
	}

	//--------------------------------------------------------------------

	/**
	 * Renders a section's contents.
	 *
	 * @param string $sectionName
	 */
	public function renderSection(string $sectionName)
	{
		if (! isset($this->sections[$sectionName]))
		{
			echo '';

			return;
		}

		foreach ($this->sections[$sectionName] as $key => $contents)
		{
			echo $contents;
			unset($this->sections[$sectionName][$key]);
		}
	}

	//--------------------------------------------------------------------

	/**
	 * Used within layout views to include additional views.
	 *
	 * @param string     $view
	 * @param array|null $options
	 * @param null       $saveData
	 *
	 * @return string
	 */
	public function include(string $view, array $options = null, $saveData = true): string
	{
		return $this->render($view, $options, $saveData);
	}

	//--------------------------------------------------------------------

	/**
	 * Returns the performance data that might have been collected
	 * during the execution. Used primarily in the Debug Toolbar.
	 *
	 * @return array
	 */
	public function getPerformanceData(): array
	{
		return $this->performanceData;
	}

	//--------------------------------------------------------------------

	/**
	 * Logs performance data for rendering a view.
	 *
	 * @param float  $start
	 * @param float  $end
	 * @param string $view
	 */
	protected function logPerformance(float $start, float $end, string $view)
	{
		if (! $this->debug)
		{
			return;
		}

		$this->performanceData[] = [
			'start' => $start,
			'end'   => $end,
			'view'  => $view,
		];
	}

	//--------------------------------------------------------------------
}
