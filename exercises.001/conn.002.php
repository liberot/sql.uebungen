<?php
/*
	uses ddl.001.root.sql 
	sqlexcdb

	fills mockup db with entries from extern json data sources
 */

require_once('conn.util.php');

function proc($files){

	// mime type for mockup
	$mime_id = q(c(), "call sqlexcdb.init_mimetype('image/png', '')");

	// timezone for mockup reasons 
	$timezone_id = q(c(), "call sqlexcdb.init_timezone('America/Los Angeles', '')");

	foreach ($files as $file) {
	
		// loads a json
		// s$doc = file_get_contents('artist.000.json');
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
			$asset_id = q(c(), "call sqlexcdb.init_asset(
				'".$asset->title."', 
				'description', 
				'".$asset->path."', 
				'".$mime_id."'
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
					'description', 
					'".$asset->path."', 
					'".$mime_id."'
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

proc(['artist.000.json', 'artist.001.json']);

exit();

/*	
select asset.title, asset.path 
	from asset, asset_to_release
		where asset.id = asset_to_release.asset_id
			and asset_to_release.release_id = 1;

select asset.title, asset.path, release_to_artist.release_id
	from artist, release_to_artist, asset_to_release, asset
		where artist.id = release_to_artist.artist_id
			and release_to_artist.release_id = asset_to_release.release_id
			and asset.id = asset_to_release.asset_id
			and artist.id = 1;

select asset.title, asset.path, release_to_artist.release_id, arelease.title 
	from artist, release_to_artist, asset_to_release, asset, arelease 
		where artist.id = release_to_artist.artist_id 
			and release_to_artist.release_id = asset_to_release.release_id 
			and release_to_artist.release_id = arelease.id 
			and asset.id = asset_to_release.asset_id 
			and artist.id = 1;
*/






