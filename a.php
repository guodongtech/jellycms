<?php
//注入脚本测试
$curlobj = curl_init();          // 初始化
curl_setopt($curlobj, CURLOPT_URL, "http://www.cjzzc.com/");       // 设置访问网页的URL
curl_setopt($curlobj, CURLOPT_RETURNTRANSFER, true);         // 执行之后不直接打印出来
$output=curl_exec($curlobj);   // 执行
$output = '<base href="http://www.cjzzc.com/" />'.$output.'<script>//window.parent.location.reload()</script>';
curl_close($curlobj);        // 关闭cURL
echo  $output;
?>