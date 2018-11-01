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
	$res = null;
	if($qres = $conn->query($sql)){
		if(true == $qres){
			// printf("succeeded: %s\n", $sql);
			if($qres instanceof mysqli_result){ 
				while($row = mysqli_fetch_assoc($qres)){
					$res[] = $row;
					// fixdiss this is .... now this is...
					foreach($row as $key=>$value){
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
	// 
	return $res;
}

// init of time zones : foreign key reasons
function initTimeZones(){
	
	if(false == ($doc = @file_get_contents('timezones.json'))){
		print "timezone is not a file\n";
	}

	if(false == ($coll = json_decode($doc))){
		print "timezone is not a json\n";
	}

	foreach($coll->timezones as $zone){
		$sql = sprintf(
			'call sqlexcdb.init_timezone("%s", "%s", "%.01f", "%s")',
			$zone->value,
			$zone->abbr,
			$zone->offset,
			$zone->text
		);
		$timezone_id = q(c(), $sql);
	}
}

// init of mime types : foreign key reasons
function initMimeTypes(){
	$mimetype_id = q(c(), "call sqlexcdb.init_mimetype('image/jpg', '')");
	$mimetype_id = q(c(), "call sqlexcdb.init_mimetype('image/png', '')");	
}

// move this to some setup of the db...
initTimeZones();
initMimeTypes();


