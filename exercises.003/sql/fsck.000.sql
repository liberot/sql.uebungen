drop database if exists fsck;
create database if not exists fsck;

use fsck;

drop table if exists address;
create table if not exists address (
	address_id int not null auto_increment,
	hausnummer char(255),
	strasse char(255),
	plz char(255),
	ort char(255),
	land char(255),
	primary key(address_id)
);

drop table if exists client;
create table if not exists client (
	client_id int not null auto_increment,
	familyname char(255),
	name char(255),
	primary key(client_id)
);

drop table if exists ref_client_address;
create table if not exists ref_client_address (
	client_id int,
	address_id int,
	foreign key(client_id) references client(client_id),
	foreign key(address_id) references address(address_id),
	primary key(client_id, address_id)
);

drop table if exists author;
create table if not exists author (
	author_id int not null auto_increment,
	bezeichnung char(255),
	primary key(author_id)
);

drop table if exists verlag;
create table if not exists verlag (
	verlag_id int not null auto_increment,
	bezeichnung char(255),
	address_id int,
	foreign key(address_id) references address(address_id),
	primary key(verlag_id)
);

drop table if exists book;
create table if not exists book (
	book_id int not null auto_increment,
	title char(255),
	description char(255),
	isbn char(255),
	releasedate date,
	verlags_id int,
	author_id int,
	foreign key(verlags_id) references verlag(verlag_id),
	foreign key(author_id) references author(author_id),
	primary key(book_id)
);

drop table if exists exemplar;
create table if not exists exemplar (
	exemplar_id int not null auto_increment,
	book_id int,
	foreign key(book_id) references book(book_id),
	primary key(exemplar_id)
);

drop table if exists ausleihe;
create table if not exists ausleihe (
	ausleihe_id int not null auto_increment,
	client_id int,
	exemplar_id int,
	ausleihedatum date,
	rueckgabedatum date,
	foreign key(client_id) references client(client_id),
	foreign key(exemplar_id) references exemplar(exemplar_id),
	primary key(ausleihe_id, client_id, exemplar_id)
);

insert into address (strasse, hausnummer, plz, ort, land) values (
	'Kieler Straße', '78', '22525', 'Hamburg', 'Schnackland'
);
insert into address (strasse, hausnummer, plz, ort, land) values (
	'Lausitzer', '178', '00525', 'Bielefeld', 'Schnackland'
);
insert into address (strasse, hausnummer, plz, ort, land) values (
	'Balaballa', '2178', 'xx525', 'Saubaur', 'Schnackland'
);

insert into client (familyname, name) values(
	'Schnaburgo', 'Jochen'
);
insert into client (familyname, name) values(
	'Schlawonar', 'Karen'
);
insert into client (familyname, name) values(
	'Specki', 'Angela' 
);

insert into ref_client_address(client_id, address_id) values(1, 1);
insert into ref_client_address(client_id, address_id) values(1, 1);
insert into ref_client_address(client_id, address_id) values(1, 2);
insert into ref_client_address(client_id, address_id) values(1, 3);
insert into ref_client_address(client_id, address_id) values(2, 1);
insert into ref_client_address(client_id, address_id) values(3, 2);

insert into author(bezeichnung) values('Leiwand');
insert into author(bezeichnung) values('Gegen Oasch');
insert into author(bezeichnung) values('Wann darf ich zur IHK-Prüfung');
insert into author(bezeichnung) values('1 2 3 Krewl');
insert into author(bezeichnung) values('Schnobalbl');

insert into verlag(bezeichnung, address_id) values(
	'Affe Verlag', 1
);
insert into verlag(bezeichnung, address_id) values(
	'Schwan Verlag', 1
);
insert into verlag(bezeichnung, address_id) values(
	'Banan Verlag', 3
);

insert into book(title, releasedate, verlags_id, author_id) values(
	'Buch 1st', date(now()), 1, 1
);
insert into book(title, releasedate, verlags_id, author_id) values(
	'Buch 2nd', date(now()), 1, 1
);
insert into book(title, releasedate, verlags_id, author_id) values(
	'Buch 3rd', date(now()), 1, 1
);
insert into book(title, releasedate, verlags_id, author_id) values(
	'Buch 4th', date(now()), 1, 2
);
insert into book(title, releasedate, verlags_id, author_id) values(
	'Buch 5th', date(now()), 1, 3
);
insert into book(title, releasedate, verlags_id, author_id) values(
	'Buch 6th', date(now()), 2, 3
);
insert into book(title, releasedate, verlags_id, author_id) values(
	'Buch 7th', date(now()), 3, 3
);

insert into exemplar(book_id) values(1);
insert into exemplar(book_id) values(1);
insert into exemplar(book_id) values(1);
insert into exemplar(book_id) values(1);

insert into exemplar(book_id) values(2);

insert into exemplar(book_id) values(3);	
insert into exemplar(book_id) values(3);	
insert into exemplar(book_id) values(3);	

insert into ausleihe(client_id, exemplar_id, ausleihedatum, rueckgabedatum) values(
	1, 1, str_to_date('1999-12-01', '%Y-%m-%d'), str_to_date('2000-12-01', '%Y-%m-%d')
);
insert into ausleihe(client_id, exemplar_id, ausleihedatum, rueckgabedatum) values(
	1, 2, str_to_date('2002-12-01', '%Y-%m-%d'), str_to_date('2003-12-01', '%Y-%m-%d')
);
insert into ausleihe(client_id, exemplar_id, ausleihedatum, rueckgabedatum) values(
	2, 3, str_to_date('2010-04-01', '%Y-%m-%d'), str_to_date('2012-12-01', '%Y-%m-%d')
);
insert into ausleihe(client_id, exemplar_id, ausleihedatum, rueckgabedatum) values(
	3, 4, str_to_date('2010-12-01', '%Y-%m-%d'), str_to_date('2011-12-01', '%Y-%m-%d')
);


drop user if exists 'liberot'@'localhost';
create user if not exists 'liberot'@'localhost' identified by 'password';
grant all privileges on fsck to 'liberot'@'localhost' identified by 'password';

flush privileges;