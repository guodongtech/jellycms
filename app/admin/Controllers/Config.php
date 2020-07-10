<?php
namespace App\Controllers;
use  \App\Models\ConfigModel;

class Config extends BaseController
{

    private $model;

    public function __construct()
    {
        $this->model = new ConfigModel();
    }

    // 应用配置列表
    public function index()
    {
		echo view('html/config.html');
    }

    // 修改配置文件
    private function modConfig($key, $value)
    {
        $value = str_replace(' ', '', $value); // 去除空格
        $value = str_replace('，', ',', $value); // 转换可能输入的中文逗号
        if (! preg_match('/^[\w\s\,\-]+$/', $value)) {
            return;
        }
        
        $config = file_get_contents(CONF_PATH . '/config.php');
        if (preg_match("'$key'", $config)) {
            if (is_numeric($value)) {
                $config = preg_replace('/(\'' . $key . '\'([\s]+)?=>([\s]+)?)[\w\'\"\s,]+,/', '${1}' . $value . ',', $config);
            } else {
                $config = preg_replace('/(\'' . $key . '\'([\s]+)?=>([\s]+)?)[\w\'\"\s,]+,/', '${1}\'' . $value . '\',', $config);
            }
        } else {
            $config = preg_replace('/(return array\()/', "$1\r\n\r\n\t'$key' => '$value',", $config); // 自动新增配置
        }
        return file_put_contents(CONF_PATH . '/config.php', $config);
    }

    // 修改数据库配置
    private function modDbConfig($key)
    {
        $value = post($key);
        
        // 如果开启伪静态时自动拷贝文件
        if ($key == 'url_rule_type' && $value == 2) {
            $soft = get_server_soft();
            if ($soft == 'iis') {
                if (! file_exists(ROOT_PATH . '/web.config')) {
                    copy(ROOT_PATH . '/rewrite/web.config', ROOT_PATH . '/web.config');
                }
            } elseif ($soft == 'apache') {
                if (! file_exists(ROOT_PATH . '/web.config')) {
                    copy(ROOT_PATH . '/rewrite/.htaccess', ROOT_PATH . '/.htaccess');
                }
            }
        }
        
        // 模板目录修改
        if (($key == 'tpl_html_dir') && $value) {
            
            // 不允许特殊字符
            if (! preg_match('/^\w+$/', $value)) {
                return;
            }
            
            $value = basename($value);
            $htmldir = $this->config('tpl_html_dir');
            $tpl_path = ROOT_PATH . current($this->config('tpl_dir')) . '/' . model('admin.content.ContentSort')->getTheme();
            
            if (! $htmldir || ! file_exists($tpl_path . '/' . $htmldir)) {
                if (! check_dir($tpl_path . '/' . $value, true)) {
                    return;
                } // 原来没有目录时只创建目录，创建失败时直接不修改
            } else {
                if ($value != $htmldir) {
                    if (file_exists($tpl_path . '/' . $value)) {
                        if (dir_copy($tpl_path . '/' . $htmldir, $tpl_path . '/' . $value)) {
                            path_delete($tpl_path . '/' . $htmldir, true); // 删除原来的
                        } else {
                            return; // 修改失败
                        }
                    } else {
                        if (! rename($tpl_path . '/' . $htmldir, $tpl_path . '/' . $value)) {
                            return; // 修改失败
                        }
                    }
                }
            }
        }
        
        // 数据分割处理
        $hander = array(
            'content_keyword_replace',
            'ip_deny',
            'ip_allow'
        );
        if (in_array($key, $hander) && $value) {
            $value = str_replace("\r\n", ",", $value); // 替换回车
            $value = str_replace("，", ",", $value); // 替换中文逗号分割符
        }
        
        if ($this->model->checkConfig("name='$key'")) {
            $this->model->modValue($key, $value);
        } elseif ($key != 'submit' && $key != 'formcheck') {
            // 自动新增配置项
            $data = array(
                'name' => $key,
                'value' => $value,
                'type' => 2,
                'sorting' => 255,
                'description' => ''
            );
            return $this->model->addConfig($data);
        }
    }
}