<?php

// create user 'dbroot'@'localhost' identified by 'password';
// grant all privileges on *.* to 'dbroot'@'localhost' with grant option;
// sets up the test db

function initDB(){
	$conn = new mysqli('localhost', 'dbroot', 'password');
	if($conn->connect_errno){
		printf("connect failed: %s\n", $conn->connect_errno);
		exit();
	};
	if(false == ($sql = @file_get_contents('ddl.001.root.sql'))){
		printf("no sql\n");
		exit();
	}
	printf($sql);
	if($qres = $conn->query($sql)){
		print_r($conn);
		if(true == $qres){
			printf("-->");
		}
		else{
			printf("no setup");
		}
	}
}

initDB();

exit();