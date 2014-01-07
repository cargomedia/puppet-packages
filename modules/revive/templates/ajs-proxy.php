<?php

$callback = (string) $_REQUEST['callback'];
ob_start();
require('ajs.php');
$content = ob_get_clean();
$content = preg_replace('/document\.write\((.*)\)/', 'return $1' , $content);
if (null === $content) {
	throw new Exception('Cannot detect revive ad source javascript');
}

echo $callback .'(function(){' . $content . '}());';
