<?php 
namespace App\Controllers;
use \App\Models\UeuploadModel;
class UeUpload extends BaseController
{
	private $config;
    public function __construct()
    {
		$this->config = '{
			/* 上传图片配置项 */
			"imageActionName": "uploadimage", /* 执行上传图片的action名称 */
			"imageFieldName": "upfile", /* 提交的图片表单名称 */
			"imageMaxSize": 2048000, /* 上传大小限制，单位B */
			"imageAllowFiles": [".png", ".jpg", ".jpeg", ".gif", ".bmp"], /* 上传图片格式显示 */
			"imageCompressEnable": true, /* 是否压缩图片,默认是true */
			"imageCompressBorder": 1600, /* 图片压缩最长边限制 */
			"imageInsertAlign": "none", /* 插入的图片浮动方式 */
			"imageUrlPrefix": "", /* 图片访问路径前缀 */
			"imagePathFormat": "/static/upload/{yyyy}{mm}{dd}/{time}{rand:6}", /* 上传保存路径,可以自定义保存路径和文件名格式 */
										/* {filename} 会替换成原文件名,配置这项需要注意中文乱码问题 */
										/* {rand:6} 会替换成随机数,后面的数字是随机数的位数 */
										/* {time} 会替换成时间戳 */
										/* {yyyy} 会替换成四位年份 */
										/* {yy} 会替换成两位年份 */
										/* {mm} 会替换成两位月份 */
										/* {dd} 会替换成两位日期 */
										/* {hh} 会替换成两位小时 */
										/* {ii} 会替换成两位分钟 */
										/* {ss} 会替换成两位秒 */
										/* 非法字符 \ : * ? " < > | */
										/* 具请体看线上文档: fex.baidu.com/ueditor/#use-format_upload_filename */

			/* 涂鸦图片上传配置项 */
			"scrawlActionName": "uploadscrawl", /* 执行上传涂鸦的action名称 */
			"scrawlFieldName": "upfile", /* 提交的图片表单名称 */
			"scrawlPathFormat": "/static/upload/{yyyy}{mm}{dd}/{time}{rand:6}", /* 上传保存路径,可以自定义保存路径和文件名格式 */
			"scrawlMaxSize": 2048000, /* 上传大小限制，单位B */
			"scrawlUrlPrefix": "", /* 图片访问路径前缀 */
			"scrawlInsertAlign": "none",

			/* 截图工具上传 */
			"snapscreenActionName": "uploadimage", /* 执行上传截图的action名称 */
			"snapscreenPathFormat": "/static/upload/{yyyy}{mm}{dd}/{time}{rand:6}", /* 上传保存路径,可以自定义保存路径和文件名格式 */
			"snapscreenUrlPrefix": "", /* 图片访问路径前缀 */
			"snapscreenInsertAlign": "none", /* 插入的图片浮动方式 */

			/* 抓取远程图片配置 */
			"catcherLocalDomain": ["127.0.0.1", "localhost", "img.baidu.com"],
			"catcherActionName": "catchimage", /* 执行抓取远程图片的action名称 */
			"catcherFieldName": "source", /* 提交的图片列表表单名称 */
			"catcherPathFormat": "/static/upload/{yyyy}{mm}{dd}/{time}{rand:6}", /* 上传保存路径,可以自定义保存路径和文件名格式 */
			"catcherUrlPrefix": "", /* 图片访问路径前缀 */
			"catcherMaxSize": 2048000, /* 上传大小限制，单位B */
			"catcherAllowFiles": [".png", ".jpg", ".jpeg", ".gif", ".bmp"], /* 抓取图片格式显示 */

			/* 上传视频配置 */
			"videoActionName": "uploadvideo", /* 执行上传视频的action名称 */
			"videoFieldName": "upfile", /* 提交的视频表单名称 */
			"videoPathFormat": "/static/upload/{yyyy}{mm}{dd}/{time}{rand:6}", /* 上传保存路径,可以自定义保存路径和文件名格式 */
			"videoUrlPrefix": "", /* 视频访问路径前缀 */
			"videoMaxSize": 102400000, /* 上传大小限制，单位B，默认100MB */
			"videoAllowFiles": [
				".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
				".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid"], /* 上传视频格式显示 */

			/* 上传文件配置 */
			"fileActionName": "uploadfile", /* controller里,执行上传视频的action名称 */
			"fileFieldName": "upfile", /* 提交的文件表单名称 */
			"filePathFormat": "/static/upload/{yyyy}{mm}{dd}/{time}{rand:6}", /* 上传保存路径,可以自定义保存路径和文件名格式 */
			"fileUrlPrefix": "", /* 文件访问路径前缀 */
			"fileMaxSize": 51200000, /* 上传大小限制，单位B，默认50MB */
			"fileAllowFiles": [
				".png", ".jpg", ".jpeg", ".gif", ".bmp",
				".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
				".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid",
				".rar", ".zip", ".tar", ".gz", ".7z", ".bz2", ".cab", ".iso",
				".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".pdf", ".txt", ".md", ".xml"
			], /* 上传文件格式显示 */

			/* 列出指定目录下的图片 */
			"imageManagerActionName": "listimage", /* 执行图片管理的action名称 */
			"imageManagerListPath": "/static/upload/", /* 指定要列出图片的目录 */
			"imageManagerListSize": 20, /* 每次列出文件数量 */
			"imageManagerUrlPrefix": "", /* 图片访问路径前缀 */
			"imageManagerInsertAlign": "none", /* 插入的图片浮动方式 */
			"imageManagerAllowFiles": [".png", ".jpg", ".jpeg", ".gif", ".bmp"], /* 列出的文件类型 */

			/* 列出指定目录下的文件 */
			"fileManagerActionName": "listfile", /* 执行文件管理的action名称 */
			"fileManagerListPath": "/static/upload/", /* 指定要列出文件的目录 */
			"fileManagerUrlPrefix": "", /* 文件访问路径前缀 */
			"fileManagerListSize": 20, /* 每次列出文件数量 */
			"fileManagerAllowFiles": [
				".png", ".jpg", ".jpeg", ".gif", ".bmp",
				".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
				".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid",
				".rar", ".zip", ".tar", ".gz", ".7z", ".bz2", ".cab", ".iso",
				".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".pdf", ".txt", ".md", ".xml"
			] /* 列出的文件类型 */
		}';
		$this->config = json_decode(preg_replace("/\/\*[\s\S]+?\*\//", "", $this->config), true);
	
    }
	public function index(){
		$action = $this->request->getGet('action');
		$callback = $this->request->getGet('callback');
		switch ($action) {
			case 'config':
				$result =  json_encode($this->config);
				break;

			/* 上传图片 */
			case 'uploadimage':
			/* 上传涂鸦 */
			case 'uploadscrawl':
			/* 上传视频 */
			case 'uploadvideo':
			/* 上传文件 */
			case 'uploadfile':
				$base64 = "upload";
				switch (htmlspecialchars($action)) {
					case 'uploadimage':
						$config = array(
							"pathFormat" => $this->config['imagePathFormat'],
							"maxSize" => $this->config['imageMaxSize'],
							"allowFiles" => $this->config['imageAllowFiles']
						);
						$fieldName = $this->config['imageFieldName'];
						break;
					case 'uploadscrawl':
						$config = array(
							"pathFormat" => $this->config['scrawlPathFormat'],
							"maxSize" => $this->config['scrawlMaxSize'],
							"allowFiles" => $this->config['scrawlAllowFiles'],
							"oriName" => "scrawl.png"
						);
						$fieldName = $this->config['scrawlFieldName'];
						$base64 = "base64";
						break;
					case 'uploadvideo':
						$config = array(
							"pathFormat" => $this->config['videoPathFormat'],
							"maxSize" => $this->config['videoMaxSize'],
							"allowFiles" => $this->config['videoAllowFiles']
						);
						$fieldName = $this->config['videoFieldName'];
						break;
					case 'uploadfile':
					default:
						$config = array(
							"pathFormat" => $this->config['filePathFormat'],
							"maxSize" => $this->config['fileMaxSize'],
							"allowFiles" => $this->config['fileAllowFiles']
						);
						$fieldName = $this->config['fileFieldName'];
						break;
				}
				$up = new UeuploadModel($fieldName, $config, $base64);
				$result = json_encode($up->getFileInfo());
				break;

			/* 列出图片 */
			case 'listimage':
				/* 判断类型 */
				switch ($action) {
					/* 列出文件 */
					case 'listfile':
						$allowFiles = $this->config['fileManagerAllowFiles'];
						$listSize = $this->config['fileManagerListSize'];
						$path = $this->config['fileManagerListPath'];
						break;
					/* 列出图片 */
					case 'listimage':
					default:
						$allowFiles = $this->config['imageManagerAllowFiles'];
						$listSize = $this->config['imageManagerListSize'];
						$path = $this->config['imageManagerListPath'];
				}
				$allowFiles = substr(str_replace(".", "|", join("", $allowFiles)), 1);

				/* 获取参数 */
				$size = null !== $this->request->getGet('size') ? htmlspecialchars($this->request->getGet('size')) : $listSize;
				$start = null !== $this->request->getGet('start') ? htmlspecialchars($this->request->getGet('start')) : 0;
				$end = $start + $size;

				/* 获取文件列表 */
				$path = $_SERVER['DOCUMENT_ROOT'] . (substr($path, 0, 1) == "/" ? "":"/") . $path;
				$files = $this->getfiles($path, $allowFiles);
				if (!count($files)) {
					$result = json_encode(array(
						"state" => "no match file",
						"list" => array(),
						"start" => $start,
						"total" => count($files)
					));
				}

				/* 获取指定范围的列表 */
				$len = count($files);
				for ($i = min($end, $len) - 1, $list = array(); $i < $len && $i >= 0 && $i >= $start; $i--){
					$list[] = $files[$i];
				}
				//倒序
				//for ($i = $end, $list = array(); $i < $len && $i < $end; $i++){
				//    $list[] = $files[$i];
				//}

				/* 返回数据 */
				$result = json_encode(array(
					"state" => "SUCCESS",
					"list" => $list,
					"start" => $start,
					"total" => count($files)
				));
				break;
			/* 列出文件 */
			case 'listfile':
				/* 判断类型 */
				switch ($action) {
					/* 列出文件 */
					case 'listfile':
						$allowFiles = $this->config['fileManagerAllowFiles'];
						$listSize = $this->config['fileManagerListSize'];
						$path = $this->config['fileManagerListPath'];
						break;
					/* 列出图片 */
					case 'listimage':
					default:
						$allowFiles = $this->config['imageManagerAllowFiles'];
						$listSize = $this->config['imageManagerListSize'];
						$path = $this->config['imageManagerListPath'];
				}
				$allowFiles = substr(str_replace(".", "|", join("", $allowFiles)), 1);

				/* 获取参数 */
				$size = null !== $this->request->getGet('size') ? htmlspecialchars($this->request->getGet('size')) : $listSize;
				$start = null !== $this->request->getGet('start') ? htmlspecialchars($this->request->getGet('start')) : 0;
				$end = $start + $size;

				/* 获取文件列表 */
				$path = $_SERVER['DOCUMENT_ROOT'] . (substr($path, 0, 1) == "/" ? "":"/") . $path;
				$files = $this->getfiles($path, $allowFiles);
				if (!count($files)) {
					$result = json_encode(array(
						"state" => "no match file",
						"list" => array(),
						"start" => $start,
						"total" => count($files)
					));
				}

				/* 获取指定范围的列表 */
				$len = count($files);
				for ($i = min($end, $len) - 1, $list = array(); $i < $len && $i >= 0 && $i >= $start; $i--){
					$list[] = $files[$i];
				}
				//倒序
				//for ($i = $end, $list = array(); $i < $len && $i < $end; $i++){
				//    $list[] = $files[$i];
				//}

				/* 返回数据 */
				$result = json_encode(array(
					"state" => "SUCCESS",
					"list" => $list,
					"start" => $start,
					"total" => count($files)
				));
				break;

			/* 抓取远程文件 */
			case 'catchimage':
				/* 上传配置 */
				$config = array(
					"pathFormat" => $CONFIG['catcherPathFormat'],
					"maxSize" => $CONFIG['catcherMaxSize'],
					"allowFiles" => $CONFIG['catcherAllowFiles'],
					"oriName" => "remote.png"
				);
				$fieldName = $CONFIG['catcherFieldName'];

				/* 抓取远程图片 */
				$list = array();
				if (null !== $this->request->getPost($fieldName)) {
					$source = $this->request->getPost($fieldName);
				} else {
					$source = $this->request->getGet($fieldName);
				}
				foreach ($source as $imgUrl) {
					$item = new UeuploadModel($imgUrl, $config, "remote");
					$info = $item->getFileInfo();
					array_push($list, array(
						"state" => $info["state"],
						"url" => $info["url"],
						"size" => $info["size"],
						"title" => htmlspecialchars($info["title"]),
						"original" => htmlspecialchars($info["original"]),
						"source" => htmlspecialchars($imgUrl)
					));
				}

				/* 返回抓取数据 */
				$result = json_encode(array(
					'state'=> count($list) ? 'SUCCESS':'ERROR',
					'list'=> $list
				));
				break;

			default:
				$result = json_encode(array(
					'state'=> '请求地址出错'
				));
				break;
		}
		/* 输出结果 */
		if (isset($callback)) {
			if (preg_match("/^[\w_]+$/", $callback)) {
				echo htmlspecialchars($callback) . '(' . $result . ')';
			} else {
				echo json_encode(array(
					'state'=> 'callback参数不合法'
				));
			}
		} else {
			echo $result;
		}
	}
	


	/**
	 * 遍历获取目录下的指定类型的文件
	 * @param $path
	 * @param array $files
	 * @return array
	 */
	private function getfiles($path, $allowFiles, &$files = array())
	{
		if (!is_dir($path)) return null;
		if(substr($path, strlen($path) - 1) != '/') $path .= '/';
		$handle = opendir($path);
		while (false !== ($file = readdir($handle))) {
			if ($file != '.' && $file != '..') {
				$path2 = $path . $file;
				if (is_dir($path2)) {
					$this->getfiles($path2, $allowFiles, $files);
				} else {
					if (preg_match("/\.(".$allowFiles.")$/i", $file)) {
						$files[] = array(
							'url'=> substr($path2, strlen($_SERVER['DOCUMENT_ROOT'])),
							'mtime'=> filemtime($path2)
						);
					}
				}
			}
		}
		return $files;
	}	
}
