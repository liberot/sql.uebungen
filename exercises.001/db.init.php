<?php
require_once('db.conn.util.php');

// init of time zones : foreign key reasons
function initTimeZones(){
	
	if(false == ($doc = @file_get_contents('./datasources/timezones.json'))){
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

initTimeZones();
initMimeTypes();

exit();
