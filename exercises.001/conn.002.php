<?php

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
						"title": "cover",
						"path": "https://cdn.theatlantic.com/assets/media/img/photo/2018/10/halloween-tk/h04_1054357306/main_1200.jpg?1540837377"
					}
				]			
			}
		]
	}
}
EOD;

$coll = json_decode($doc);

function c(){
	$conn = new mysqli('localhost', 'liberot', 'password', 'sqlexcdb');
	if($conn->connect_errno){
		printf("connect failed: %s\n", $conn->connect_errno);
		exit();
	};
	return $conn;
};

function q($conn, $sql){
	$res = null;
	if($qres = $conn->query($sql)){
		if(true == $qres){
			printf("succeeded: %s\n", $sql);
			if($qres instanceof mysqli_result){ 
				while($row = mysqli_fetch_assoc($qres)){
					foreach($row as $key=>$value){
						print(sprintf("key: %s value: %s\n", $key, $value));
						if('last_insert_id()' == $key){
							$res = $value;
						}
					}
				}
				mysqli_free_result($qres);
			}
		}
		else if(false == $qres){
			printf("q failed: %s\n", $conn->error);
		}
	}
	else{
		printf("q failed: %s\n", $conn->error);
	}
	$conn->close();
	return $res;
}

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