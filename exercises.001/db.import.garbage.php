<?php
/*
	uses ./datasources/ddl.001.root.sql 
	sqlexcdb

	fills db with random mockup characters

 */

require_once('db.conn.util.php');

function proc(){
	
	// mockup
	$timezone_id = q("call sqlexcdb.select_timezone_id(\"Pacific Standard Time\")")[0]['id'];	
	$mimetype_id = q("call sqlexcdb.select_mimetype_id(\"image/png\")")[0]['id'];	

	$i = 903;
	while($i--){
		
		print(".");

		$artist_id = q("call sqlexcdb.init_artist(
			'".rstr()."', 
			'".rstr()."'
			)"
		);
		$ii = rand(0, 25);
		while($ii--){
			$asset_id = q("call sqlexcdb.init_asset(
				'".rstr()."', 
				'".rstr()."', 
				'".rstr()."', 
				'".$mimetype_id."'
				)"
			);
			$link_id = q("call sqlexcdb.link_asset_to_artist(
				'".$asset_id."', 
				'".$artist_id."', 
				'".rstr()."', 
				'".rstr()."', 
				'".rstr()."'
				)"
			);
		};
		$d = date("Y-m-d H:i:s");
		$release_id = q("call sqlexcdb.init_release(
			'".rstr()."', 
			'".rstr()."',
			'".$d."',
			'".$timezone_id."'
			)"
		);
		// links release
		$link_id = q("call sqlexcdb.link_release_to_artist(
			'".$release_id."', 
			'".$artist_id."'
			)"
		);
		$ii = rand(0, 25);
		while($ii--){
			$asset_id = q("call sqlexcdb.init_asset(
				'".rstr()."', 
				'".rstr()."', 
				'".rstr()."', 
				'".$mimetype_id."'
				)"
			);
			$link_id = q("call sqlexcdb.link_asset_to_release(
				'".$asset_id."', 
				'".$release_id."', 
				'".rstr()."', 
				'".rstr()."', 
				'".rstr()."'
				)"
			);
		};
	}
}

proc();

exit();
