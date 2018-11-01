<?php

require_once('db.conn.util.php');

$sql = "call sqlexcdb.select_assets_by_release_id(1)";
print_r($sql);
print_r(q(c(), $sql));

$sql = "call sqlexcdb.select_assets_by_release_id(2)";
print_r($sql);
print_r(q(c(), $sql));

$sql = "call sqlexcdb.select_assets_by_artist_id(1)";
print_r($sql);
print_r(q(c(), $sql));

$sql = "call sqlexcdb.select_assets_by_artist_id(2)";
print_r($sql);
print_r(q(c(), $sql));

$sql = "call sqlexcdb.select_assets_by_artist_id_2nd(1)";
print_r($sql);
print_r(q(c(), $sql));

exit();
