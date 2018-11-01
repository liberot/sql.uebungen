PHP 7.0.30-0+deb9u1 (cli) (built: Jun 14 2018 13:50:25) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.0.0, Copyright (c) 1998-2017 Zend Technologies
    with Zend OPcache v7.0.30-0+deb9u1, Copyright (c) 1999-2017, by Zend Technologies

mysql  Ver 15.1 Distrib 10.1.26-MariaDB, for debian-linux-gnu (x86_64) using readline 5.2

/etc/debian_version 9.5

:::::::::::::::::::::::::::::::::::::::::::::::::
>sudo mysql < ./sql/ddl.001.root.sql
>php ./db.init.php
>php ./db.import.source.php 
>php ./db.import.garbage.php
>php ./db.select.php
