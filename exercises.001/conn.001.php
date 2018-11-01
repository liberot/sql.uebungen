<?php
/*
	uses ddl.001.root.sql 
	sqlexcdb

	fills mockup db with random characters

 */

require_once('conn.util.php');

// mockup
$timezone_id = q(c(), "call sqlexcdb.select_timezone_id(\"Pacific Standard Time\")")[0]['id'];	
$mimetype_id = q(c(), "call sqlexcdb.select_mimetype_id(\"image/png\")")[0]['id'];	


$i = 103;
while($i--){
	
	print(".");

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
			'".$mimetype_id."'
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
	// links release
	$link_id = q(c(), "call sqlexcdb.link_release_to_artist(
		'".$release_id."', 
		'".$artist_id."'
		)"
	);
	$ii = rand(0, 25);
	while($ii--){
		$asset_id = q(c(), "call sqlexcdb.init_asset(
			'".rstr()."', 
			'".rstr()."', 
			'".rstr()."', 
			'".$mimetype_id."'
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
q(c(), "call sqlexcdb.select_artist('%KB%')");

exit();
