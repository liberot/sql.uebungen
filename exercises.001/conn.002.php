<?php

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
			}
		]
	}
}
EOD;

$coll = json_decode($doc);

// adds an artist into the db
$artist_id = q(c(), "call sqlexcdb.init_artist(
	'".$coll->artist->identification."', 
	'".$coll->artist->description."'
	)"
);

// mime type for mockup
$mime_id = q(c(), "call sqlexcdb.init_mimetype('image/png', '')");

// adds the asset of the artist into the db
$asset_id = q(c(), "call sqlexcdb.init_asset(
	'".$coll->artist->assets[0]->title."', 
	'description', 
	'".$coll->artist->assets[0]->path."', 
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

exit();