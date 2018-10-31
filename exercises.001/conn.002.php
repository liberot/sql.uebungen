<?php
/*
	uses ddl.001.root.sql 
	sqlexcdb

 */

require_once('conn.util.php');

$doc = <<<EOD
{
	"artist": {
		"identification": "Laars Jucken",
		"description": "",
		"assets": [
			{ 
				"title": "gesicht",
			 	"path": "https://cdn.theatlantic.com/assets/media/img/photo/2018/10/halloween-tk/h02_RTX6GX9S/main_1200.jpg?1540839254"			
			}
		],
		"releases": [
			{
				"title": "Zwei Ei K\u00e4ptn",
				"description": "",
				"assets": [
					{ 
						"title": "1st cover imago",
						"path": "https://cdn.theatlantic.com/assets/media/img/photo/2018/10/halloween-tk/h04_1054357306/main_1200.jpg?1540837377"
					},
					{ 
						"title": "2nd cover image",
						"path": "https://cdn.theatlantic.com/assets/media/img/photo/2018/10/halloween-tk/h08_1052479722/main_1200.jpg?1540839254"
					}
				]			
			},
			{
				"title": "Zum blauen Schwimmer",
				"description": "",
				"assets": [
					{ 
						"title": "Habe die Ehre, hebe die Haare.",
						"path": "https://cdn.theatlantic.com/assets/media/img/photo/2018/10/halloween-tk/h20_1054577334/main_1200.jpg?1540837378"
					}
				]			
			}
		]
	}
}
EOD;

$coll = json_decode($doc);

// mime type for mockup
$mime_id = q(c(), "call sqlexcdb.init_mimetype('image/png', '')");

// timezone for mockup reasons 
$timezone_id = q(c(), "call sqlexcdb.init_timezone('America/Los Angeles', '')");

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

exit();




