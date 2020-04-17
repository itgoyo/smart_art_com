<?php
/*
* @link http://kodcloud.com/
* @author warlee | e-mail:kodcloud@qq.com
* @copyright warlee 2014.(Shanghai)Co.,Ltd
* @license http://kodcloud.com/tools/license/license.txt
*/


/**
 * client ip address
 * 
 * @param boolean $s_type ip类型[ip|long]
 * @return string $ip
 */
function get_client_ip($b_ip = true){
	$arr_ip_header = array( 
		"HTTP_CLIENT_IP",
		"HTTP_X_FORWARDED_FOR",
		"REMOTE_ADDR",
		"HTTP_CDN_SRC_IP",
		"HTTP_PROXY_CLIENT_IP",
		"HTTP_WL_PROXY_CLIENT_IP"
	);
	$client_ip = 'unknown';
	foreach ($arr_ip_header as $key) {
		if (!empty($_SERVER[$key]) && strtolower($_SERVER[$key]) != "unknown") {
			$client_ip = $_SERVER[$key];
			break;
		}
	}
	if ($pos = strpos($client_ip,',')){
		$client_ip = substr($client_ip,$pos+1);
	}
	return $client_ip;
}

function get_url_link($url){
	if(!$url) return "";
	$res = parse_url($url);
	$port = (empty($res["port"]) || $res["port"] == '80')?'':':'.$res["port"];
	return $res['scheme']."://".$res["host"].$port.$res['path'];
}
function get_url_root($url){
	if(!$url) return "";
	$res = parse_url($url);
	$port = (empty($res["port"]) || $res["port"] == '80')?'':':'.$res["port"];
	return $res['scheme']."://".$res["host"].$port.'/';
}
function get_url_domain($url){
	if(!$url) return "";
	$res = parse_url($url);
	return $res["host"];
}
function get_url_scheme($url){
	if(!$url) return "";
	$res = parse_url($url);
	return $res['scheme'];
}

function get_host() {
	//兼容子目录反向代理:只能是前端js通过cookie传入到后端进行处理
	if(defined('GLOBAL_DEBUG') && isset($_COOKIE['HOST']) && isset($_COOKIE['APP_HOST'])){
		return $_COOKIE['HOST'];
	}

	$protocol = (!empty($_SERVER['HTTPS'])
				 && $_SERVER['HTTPS'] !== 'off'
				 || $_SERVER['SERVER_PORT'] === 443) ? 'https://' : 'http://';

	if( isset($_SERVER['HTTP_X_FORWARDED_PROTO']) &&
		strlen($_SERVER['HTTP_X_FORWARDED_PROTO']) > 0 ){
		$protocol = $_SERVER['HTTP_X_FORWARDED_PROTO'].'://';
	}
	$url_host = $_SERVER['SERVER_NAME'].($_SERVER['SERVER_PORT']=='80' ? '' : ':'.$_SERVER['SERVER_PORT']);
	$host = isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : $url_host;
	$host = isset($_SERVER['HTTP_X_FORWARDED_HOST']) ? $_SERVER['HTTP_X_FORWARDED_HOST'] : $host;//proxy
	return $protocol.$host;
}
// current request url
function this_url(){
	$url = rtrim(get_host(),'/').'/'.ltrim($_SERVER['REQUEST_URI'],'/');
	return $url;
}

//解决部分主机不兼容问题
function webroot_path($basic_path){
	$webRoot = str_replace($_SERVER['SCRIPT_NAME'],'',$_SERVER['SCRIPT_FILENAME']);
	$webRoot = rtrim(str_replace(array('\\','\/\/','\\\\'),'/',$webRoot),'/').'/';
	if( substr($basic_path,0,strlen($webRoot)) == $webRoot ){
		return $webRoot;
	}

	$webRoot = $_SERVER['DOCUMENT_ROOT'];
	$webRoot = rtrim(str_replace(array('\\','\/\/','\\\\'),'/',$webRoot),'/').'/';
	if( substr($basic_path,0,strlen($webRoot)) == $webRoot ){
		return $webRoot;
	}
	return $basic_path;
}

function ua_has($str){
	if(!isset($_SERVER['HTTP_USER_AGENT'])){
		return false;
	}
	if(strpos($_SERVER['HTTP_USER_AGENT'],$str) ){
		return true;
	}
	return false;
}
function is_wap(){   
	if(!isset($_SERVER['HTTP_USER_AGENT'])){
		return false;
	} 
	if(preg_match('/(up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone|iphone|ipad|ipod|android|xoom|miui)/i', 
		strtolower($_SERVER['HTTP_USER_AGENT']))){
		return true;
	}
	if((isset($_SERVER['HTTP_ACCEPT'])) && 
		(strpos(strtolower($_SERVER['HTTP_ACCEPT']),'application/vnd.wap.xhtml+xml') !== false)){
		return true;
	}
	return false;
}

function parse_headers($raw_headers){
	$headers = array();
	$key = '';
	foreach (explode("\n", $raw_headers) as $h) {
		$h = explode(':', $h, 2);
		if (isset($h[1])) {
			if ( ! isset($headers[$h[0]])) {
				$headers[$h[0]] = trim($h[1]);
			} elseif (is_array($headers[$h[0]])) {
				$headers[$h[0]] = array_merge($headers[$h[0]], array(trim($h[1])) );
			} else {
				$headers[$h[0]] = array_merge(array($headers[$h[0]]), array(trim($h[1])) );
			}
			$key = $h[0];
		} else {
			if (substr($h[0], 0, 1) === "\t") {
				$headers[$key] .= "\r\n\t" . trim($h[0]);
			} elseif ( ! $key) {
				$headers[0] = trim($h[0]);
			}
			trim($h[0]);
		}
	}
	return $headers;
}

//多人同时上传同一个文件；或上传到多个服务;
$curlCurrentFile = false;
function curl_progress_bind($file,$uuid='',$download=false){
	if(!$GLOBALS['curlCurrentFile']){
		$cacheFile = TEMP_PATH.'/curlProgress/'.md5($file.$uuid).'.log';
		mk_dir(get_path_father($cacheFile));
		@touch($cacheFile);
		if(!file_exists($cacheFile)){
			return;
		}
		$GLOBALS['curlCurrentFile'] = array(
			'path'		 => $file,
			'uuid'		 => $uuid,
			'time'		 => 0,
			'setNum'	 => 0,
			'cacheFile'	 => $cacheFile,
			'download' 	 => $download
		);
	}
	curl_progress_set(false,0,0,0,0);
}
function curl_progress_set(){
	$fileInfo = $GLOBALS['curlCurrentFile'];
	$file = $fileInfo['path'];
	$cacheFile = $fileInfo['cacheFile'];
	if( !is_array($fileInfo) || 
		mtime() - $fileInfo['time'] <= 0.3){//每300ms做一次记录
		return;
	}
	//进度文件被删除则终止传输;
	clearstatcache();
	if( !file_exists($cacheFile) || 
		!file_exists($file) ){
		exit;
	}

	$GLOBALS['curlCurrentFile']['time'] = mtime();
	$GLOBALS['curlCurrentFile']['setNum'] += 1;
	$args = func_get_args();
	if (is_resource($args[0])) {// php 5.5
		array_shift($args);
	}
	$downTotal = $args[0];
	$downSize = $args[1];
	$upTotal = $args[2];
	$upSize = $args[3];

	//默认上传
	$size = @filesize($file);
	$sizeSuccess = $upSize;
	if($fileInfo['download']){
		$size = $downTotal;
		$sizeSuccess = $downSize;
	}
	$json = array(
		'name'			=> substr(rawurlencode(get_path_this($file)),-10),
		'taskUuid'		=> $fileInfo['uuid'],
		'type'		 	=> $fileInfo['download']?'fileDownload':'fileUpload',
		'timeStart' 	=> time(),

		'sizeTotal'		=> $size,
		'sizeSuccess'	=> $sizeSuccess,
		'progress'	 	=> 0,
		'timeUse'	 	=> 0,
		'timeNeed'		=> 0,
		'speed'			=> 0,
		'logList'		=> array()
	);
	//write_log(array($args,$size,$sizeSuccess),'ttt');
	if(time() - filemtime($cacheFile) <= 10){//10s内才处理;同一个文件
		$data = @json_decode(file_get_contents($cacheFile),true);
		$json = $data?$data:$json;
	}else{
		del_file($cacheFile);
		touch($cacheFile);
	}

	//更新数据
	$logList = &$json['logList'];
	if(count($logList) >=10 ){
		$logList = array_slice($logList,-10);
	}

	$current = array('time'=>time(),'sizeSuccess'=>$sizeSuccess);
	if(count($logList) == 0){
		$logList[] = $current;
	}else{
		$last = $logList[count($logList)-1];
		if(time() == $last['time']){
			$logList[count($logList)-1] = $current;
		}else{
			$logList[] = $current;
		}
	}

	//计算速度
	$first = $logList[0];
	$last  = $logList[count($logList)-1];
	$time  = $last['time'] - $first['time'];
	$speed = $time?($last['sizeSuccess'] - $first['sizeSuccess'])/$time : 0;
	if($speed <0 || $speed>500*1024*1024){
		$speed = 0;
	}
	$timeNeed = $speed ? ($size - $sizeSuccess)/$speed:0;
	$progress = 0;
	if($size != 0 ){
		$progress  = ($sizeSuccess>=$size)?1:$sizeSuccess/$size;
	}
	$json['sizeTotal']  	= $size;
	$json['sizeSuccess']	= $sizeSuccess;
	$json['progress'] 		= $progress;
	$json['timeUse']  		= time() - $json['timeStart'];
	$json['timeNeed'] 		= intval($timeNeed);
	$json['speed'] = intval($speed);
	file_put_contents($cacheFile,json_encode($json));
}
function curl_progress_get($file,$uuid=''){
	$cacheFile = TEMP_PATH.'/curlProgress/'.md5($file.$uuid).'.log';
	if(!file_exists($cacheFile) || $file == ''){
		return -1;
	}
	$data = @json_decode(file_get_contents($cacheFile),true);
	if(is_array($data)){
		unset($data['logList']);
		return $data;
	}
	return -3;
}

// https://segmentfault.com/a/1190000000725185
// http://blog.csdn.net/havedream_one/article/details/52585331 
// php7.1 curl上传中文路径文件失败问题？【暂时通过重命名方式解决】
function url_request($url,$method='GET',$data=false,$headers=false,$options=false,$json=false,$timeout=3600){
	if(!$url){
		return array(
			'data'		=> 'url error! url='.$url,
			'code'		=> 0
		);
	}
	ignore_timeout();
	$ch = curl_init();
	$upload = false;
	if(is_array($data)){//上传检测并兼容
		foreach($data as $key => &$value){
			if(!is_string($value) || substr($value,0,1) !== "@"){
				continue;
			}
			$upload = true;
			$path = ltrim($value,'@');
			$filename = iconv_app(get_path_this($path));
			$mime = get_file_mime(get_path_ext($filename));
			if(isset($data['curlUploadName'])){//自定义上传文件名;临时参数
				$filename = $data['curlUploadName'];
				unset($data['curlUploadName']);
			}
			if (class_exists('\CURLFile')){
				$value = new CURLFile(realpath($path),$mime,$filename);
			}else{
				$value = "@".realpath($path).";type=".$mime.";filename=".$filename;
			}
			//有update且method为PUT
			if($method == 'PUT'){
				curl_setopt($ch, CURLOPT_PUT,1);
				curl_setopt($ch, CURLOPT_INFILE,@fopen($path,'r'));
				curl_setopt($ch, CURLOPT_INFILESIZE,@filesize($path));				
			}

			//上传进度记录并处理
			curl_progress_bind($path);
			curl_setopt($ch, CURLOPT_NOPROGRESS, false);
			curl_setopt($ch, CURLOPT_PROGRESSFUNCTION,'curl_progress_set');
		}
	}
	if($upload){
		if (class_exists('\CURLFile')){
			curl_setopt($ch, CURLOPT_SAFE_UPLOAD, true);
		} else {
			if (defined('CURLOPT_SAFE_UPLOAD')) {
				curl_setopt($ch, CURLOPT_SAFE_UPLOAD, false);
			}
		}
	}

	// post数组或拼接的参数；不同方式服务器兼容性有所差异
	// http://blog.csdn.net/havedream_one/article/details/52585331 
	// post默认用array发送;content-type为x-www-form-urlencoded时用key=1&key=2的形式
	if (is_array($data) && is_array($headers) && $method != 'DOWNLOAD'){
		foreach ($headers as $key) {
			if(strstr($key,'x-www-form-urlencoded')){
				$data = http_build_query($data);
				break;
			}
		}
	}
	if($method == 'GET' && $data){
		if(is_array($data)){
			$data = http_build_query($data);
		}
		if(strstr($url,'?')){
			$url = $url.'&'.$data;
		}else{
			$url = $url.'?'.$data;
		}
	}
	curl_setopt($ch, CURLOPT_URL,$url);
	curl_setopt($ch, CURLOPT_HEADER,1);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
	curl_setopt($ch, CURLOPT_PROTOCOLS, CURLPROTO_HTTP | CURLPROTO_HTTPS);
	curl_setopt($ch, CURLINFO_HEADER_OUT, 1);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
	curl_setopt($ch, CURLOPT_SSLVERSION,1);//1|5|6; http://t.cn/RZy5nXF
	curl_setopt($ch, CURLOPT_TIMEOUT,$timeout);
	curl_setopt($ch, CURLOPT_REFERER,get_url_link($url));
	curl_setopt($ch, CURLOPT_USERAGENT,'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36');
	if($headers){
		if(is_string($headers)){
			$headers = array($headers);
		}
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
	}

	switch ($method) {
		case 'GET':
			curl_setopt($ch,CURLOPT_HTTPGET,1);
			break;
		case 'DOWNLOAD':
			//远程下载到指定文件；进度条
			$downTemp = $data.'.'.rand_string(5);
			$fp = fopen ($downTemp,'w+');
			curl_progress_bind($downTemp,'',true);//下载进度
			curl_setopt($ch, CURLOPT_NOPROGRESS, false);
			curl_setopt($ch, CURLOPT_PROGRESSFUNCTION,'curl_progress_set');

			curl_setopt($ch, CURLOPT_HTTPGET,1);
			curl_setopt($ch, CURLOPT_HEADER,0);//不输出头
			curl_setopt($ch, CURLOPT_FILE, $fp);
			//CURLOPT_RETURNTRANSFER 必须放在CURLOPT_FILE前面;否则出问题
			break;
		case 'HEAD':
			curl_setopt($ch, CURLOPT_NOBODY, true);
			break;
		case 'POST':
			curl_setopt($ch, CURLOPT_POST, 1);
			curl_setopt($ch, CURLOPT_POSTFIELDS,$data);
			break;
		case 'OPTIONS':
		case 'PATCH':
		case 'DELETE':
		case 'PUT':
			curl_setopt($ch, CURLOPT_CUSTOMREQUEST,$method);
			curl_setopt($ch, CURLOPT_POSTFIELDS,$data);
