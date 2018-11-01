<?php

require_once('db.conn.util.php');

$sql = "call sqlexcdb.select_assets_by_release_id(1)";
print_r($sql);
print_r(q($sql));

$sql = "call sqlexcdb.select_assets_by_release_id(2)";
print_r($sql);
print_r(q($sql));

$sql = "call sqlexcdb.select_assets_by_artist_id(1)";
print_r($sql);
print_r(q($sql));

$sql = "call sqlexcdb.select_assets_by_artist_id(2)";
print_r($sql);
print_r(q($sql));

$sql = "call sqlexcdb.select_assets_by_artist_id_2nd(1)";
print_r($sql);
print_r(q($sql));

$sql = "call sqlexcdb.select_artist('%Yummy Yummi Yummi i got love in my tummy and i feel like lovers do%')";
$res = q($sql);
print_r($sql);
print_r($res);

$sql = "call sqlexcdb.select_artist('%KB%')";
$res = q($sql);
print_r($sql);
print_r($res);

exit();
