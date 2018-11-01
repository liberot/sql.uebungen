<?php
/*
	uses ./resources/ddl.001.root.sql 
	sqlexcdb

	fills mockup db with entries from extern json data sources

 */

require_once('db.conn.util.php');

function proc($files){

	$timezone_id = q(c(), "call sqlexcdb.select_timezone_id(\"Pacific Standard Time\")")[0]['id'];	
	// mimetype_ids will probably will be typed const
	$mimetype_id = q(c(), "call sqlexcdb.select_mimetype_id(\"image/png\")")[0]['id'];	

	foreach ($files as $file) {
	
		// loads a json
		if(false == ($doc = @file_get_contents($file))){
			print "not a file: ".$file."\n";
			continue;
		}

		// 
		if(false == ($coll = json_decode($doc))){
			print "not a json: ".$file."\n";
			continue;
		}

		// adds an artist into the db
		$artist_id = q(c(), "call sqlexcdb.init_artist(
			'".$coll->artist->identification."', 
			'".$coll->artist->description."'
			)"
		);

		// adds assets of the artist into the db
		foreach($coll->artist->assets as $asset){
			// 
			$asset_id = q(c(), "call sqlexcdb.init_asset(
				'".$asset->title."', 
				'description', 
				'".$asset->path."', 
				'".$mimetype_id."'
				)"
			);
			// links asset to artist
			$link_id = q(c(), "call sqlexcdb.link_asset_to_artist(
				'".$asset_id."', 
				'".$artist_id."', 
				'meta', 
				'title', 
				'description'
				)"
			);
		}

		// adds releases
		foreach ($coll->artist->releases as $release) {
			// print_r($release);
			// date for mockup reasons
			$d = date("Y-m-d H:i:s");
			// inits a release
			$release_id = q(c(), "call sqlexcdb.init_release(
				'".$release->title."', 
				'".$release->description."',
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
			// inits assets
			foreach($release->assets as $asset){
				// inits asset
				$asset_id = q(c(), "call sqlexcdb.init_asset(
					'".$asset->title."', 
					'".$asset->description."', 
					'".$asset->path."', 
					'".$mimetype_id."'
					)"
				);
				// links asset to release 
				$link_id = q(c(), "call sqlexcdb.link_asset_to_release(
					'".$asset_id."', 
					'".$release_id."', 
					'meta', 
					'title', 
					'description'
					)"
				);				
			}
		}
	}
}

proc(['./datasources/artist.000.json', './datasources/artist.001.json']);

exit();

