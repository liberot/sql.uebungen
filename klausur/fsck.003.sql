drop database if exists klausur;
create database klausur 
	character set utf8mb4 
	collate utf8mb4_unicode_ci
;

use klausur;

drop table if exists kunde;
create table kunde (
  kundennummer int,
  anrede char(255),
  vorname char(255),
  nachname char(255),
  firma char(255),
  strasse char(255),
  hausnummer char(255),
  plz char(255),
  ort char(255),
  primary key(kundennummer)
);

drop table if exists angebot;
create table angebot (
  angebotsnummer int,
  kundennummer int,
  kopfdaten char(255),
  anfragedatum date,
  erstellungsdatum date,
  fussdaten char(255),
  foreign key(kundennummer) references kunde(kundennummer),
  primary key(angebotsnummer)
);

drop table if exists artikel;
create table artikel (
	artikelnummer int,
	bezeichnung char(255),
	listenpreis decimal(10,2),
  	primary key(artikelnummer)
);

drop table if exists position;
create table position (
  pos int,
  angebotsnummer int,
  artikelnummer int,
  menge int,
  foreign key(artikelnummer) references artikel(artikelnummer),
  primary key(pos, angebotsnummer)
);

insert into artikel
	(artikelnummer, bezeichnung, listenpreis)
	values(1, 'Seife', 10.99);

insert into artikel
	(artikelnummer, bezeichnung, listenpreis)
	values(2, 'Bier', 1.99);

insert into artikel
	(artikelnummer, bezeichnung, listenpreis)
	values(3, 'Flugticket', 21.99);
  
insert into 
	kunde(
		kundennummer, 
		anrede, 
		vorname, 
		nachname, 
		firma, 
		strasse, 
		hausnummer, 
		plz, 
		ort
	)
values(
	1, 
		'Herr', 
		'Mike', 
		'Singapur', 
		'Die blinden Aktivisten', 
		'Kieler', 
		'72a', 
		'22224', 
		'Fötjern'
);

insert into 
	kunde(
		kundennummer, 
		anrede, 
		vorname, 
		nachname, 
		firma, 
		strasse, 
		hausnummer, 
		plz, 
		ort
	)
values(
	2, 
		'Frau', 
		'Ulla', 
		'Trulla', 
		'The Continious Spirit of Ulla', 
		'Dr Erlich Drive', 
		'352', 
		'91000', 
		'Snofdeern'
);

# angebot 1
insert into angebot
	(angebotsnummer, kundennummer, kopfdaten, anfragedatum, erstellungsdatum, fussdaten)
	values(
		1,
		1,
		'Mühsam nährt sich das Eichhörnchen',
		str_to_date('2009-10-01', '%Y-%m-%d'),
		str_to_date('2009-10-02', '%Y-%m-%d'),
		'Homo Homini Lupus'
	)
;

insert into position
	(pos, angebotsnummer, artikelnummer, menge)
	values(1, 1, 1, 1)
;

insert into position
	(pos, angebotsnummer, artikelnummer, menge)
	values(2, 1, 2, 1)
;

insert into position
	(pos, angebotsnummer, artikelnummer, menge)
	value(3, 1, 3, 1)
;

insert into position
	(pos, angebotsnummer, artikelnummer, menge)
	values(4, 1, 3, 2)
;

insert into position
	(pos, angebotsnummer, artikelnummer, menge)
	values(5, 1, 3, 2)
;

# angebot 2
insert into angebot
	(angebotsnummer, kundennummer, kopfdaten, anfragedatum, erstellungsdatum, fussdaten)
	values(
		2,
		2,
		'And The Winner Is Mister Misses',
		str_to_date('2016-01-02', '%Y-%m-%d'),
		str_to_date('2016-01-02', '%Y-%m-%d'),
		'Homo Homini Lupus'
	)
;	

insert into position
	(pos, angebotsnummer, artikelnummer, menge)
	values(1, 2, 1, 100)
;

insert into position
	(pos, angebotsnummer, artikelnummer, menge)
	value(2, 2, 2, 100)
;

insert into position
	(pos, angebotsnummer, artikelnummer, menge)
	values(3, 2, 3, 100)
;

# angebot 3
insert into angebot
	(angebotsnummer, kundennummer, kopfdaten, anfragedatum, erstellungsdatum, fussdaten)
	values(
		3,
		2,
		'Narrisch wärrn geht ned.',
		str_to_date('2018-02-01', '%Y-%m-%d'),
		str_to_date('2018-02-01', '%Y-%m-%d'),
		'Homo Homini Lupus'
	)
;	

insert into position
	(pos, angebotsnummer, artikelnummer, menge)
	values(1, 3, 1, 25)
;

insert into position
	(pos, angebotsnummer, artikelnummer, menge)
	values(2, 3, 2, 1)
;

insert into position
	(pos, angebotsnummer, artikelnummer, menge)
	values(3, 3, 3, 100000)
;
