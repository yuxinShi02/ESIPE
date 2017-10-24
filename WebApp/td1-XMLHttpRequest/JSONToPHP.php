<?php
$file = file_get_contents('format.json');
$json = json_decode($file,true);

foreach ($json as $key1 => $value1) {
	if ( $json[$key1]["Age"] < 20 ) {
		print_r($json[$key1]);
	}
}
?>