<?php

function rstr(){
	$tt = '';
	$ii = 27;
	while($ii--){
		$tt.= chr(62 +(rand(0, 25)));
	}	
	return $tt;
};

function c(){
	$conn = new mysqli('localhost', 'liberot', 'password', 'sqlexcdb');
	if($conn->connect_errno){
		printf("connect failed: %s\n", $conn->connect_errno);
		exit();
	};
	return $conn;
};

function q($conn, $sql){
	$ret = null;
	if($res = $conn->query($sql)){
		if(true == $res){
			printf("succeeded: %s\n", $sql);
			if($res instanceof mysqli_result){ 
				while($row = mysqli_fetch_assoc($res)){
					foreach($row as $key=>$value){
						if('last_insert_id()' == $key){
							$ret = $value;
						}
					}
				}
				mysqli_free_result($res);
			}
		}
		else if(false == $res){
			printf("failed: %s\n", $conn->error);
		}
	}
	else{
		printf("failed: %s\n", $conn->error);
	}
	$conn->close();
	return $ret;
}

$mime_id = q(c(), "call sqlexcdb.init_mimetype('image/jpg', '')");
$mime_id = q(c(), "call sqlexcdb.init_mimetype('image/gif', '')");
$mime_id = q(c(), "call sqlexcdb.init_mimetype('image/png', '')");

$timezone_id = q(c(), "call sqlexcdb.init_timezone('America/Los Angeles', '')");

$i = 103;
while($i--){
	$artist_id = q(c(), "call sqlexcdb.init_artist(
		'".rstr()."', 
		'".rstr()."'
		)"
	);
	$ii = rand(0, 25);
	while($ii--){
		$asset_id = q(c(), "call sqlexcdb.init_asset(
			'".rstr()."', 
			'".rstr()."', 
			'".rstr()."', 
			'".$mime_id."'
			)"
		);
		$link_id = q(c(), "call sqlexcdb.link_asset_to_artist(
			'".$asset_id."', 
			'".$artist_id."', 
			'".rstr()."', 
			'".rstr()."', 
			'".rstr()."'
			)"
		);
	};
	$d = date("Y-m-d H:i:s");
	$release_id = q(c(), "call sqlexcdb.init_release(
		'".rstr()."', 
		'".rstr()."',
		'".$d."',
		'".$timezone_id."'
		)"
	);
	$ii = rand(0, 25);
	while($ii--){
		$asset_id = q(c(), "call sqlexcdb.init_asset(
			'".rstr()."', 
			'".rstr()."', 
			'".rstr()."', 
			'".$mime_id."'
			)"
		);
		$link_id = q(c(), "call sqlexcdb.link_asset_to_release(
			'".$asset_id."', 
			'".$release_id."', 
			'".rstr()."', 
			'".rstr()."', 
			'".rstr()."'
			)"
		);
	};
	
}

/*
select asset.id, asset.title, asset.description, asset.path 
	from asset_to_artist, asset 
		where asset_to_artist.asset_id = asset.id 
			and asset_to_artist.artist_id = 3952;
*/

q(c(), "call sqlexcdb.select_artist('%Yummy Yummi Yummi i got love in my tummy and i feel like lovers do%')");

exit();
