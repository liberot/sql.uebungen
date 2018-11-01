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
			printf("succeeded: %s\n", $sql);
			if($qres instanceof mysqli_result){ 
				while($row = mysqli_fetch_assoc($qres)){
					foreach($row as $key=>$value){
						print(sprintf("key: %s value: %s\n", $key, $value));
						$res = $value;
						// this is .... now this is...
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


