<?php

$conn = new mysqli('localhost', 'liberot', 'password', 'sqlexercise');

if($conn->connect_errno){
	printf("connect failed: %s\n", $conn->connect_errno);
	exit();
};

function q($conn, $sql){
	if($res = $conn->query($sql)){
		if(true == $res){
			printf("succeeded: %s\n", $sql);
			if($res instanceof mysqli_result){ 
				while($row = mysqli_fetch_assoc($res)){
					print_r($row);
				}
				mysqli_free_result($res);
			}
		}
		else if(false == $res){
			printf("failed: %s\n", $conn->error);
		}
	}
	else{
		printf("failed: %s\n", $conn->error);
	}
}

$i = 10000;
while($i--){
	$tt = '';
	$ii = 63;
	while($ii--){
		$tt.= chr(41 +(rand(0, 25)));
	}
	q($conn, sprintf("insert into testtable values(null, 'yol: %s');", $tt));
}

// q($conn, 'select * from testtable;');
q($conn, 'select * from testtable where data like "%12%"');

$conn->close();

exit();