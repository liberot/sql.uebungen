/*
	Database of FIAE 2011 Wi GA 1 AE 
 */


drop database if exists nauticsoft;
create database nauticsoft 
	character set utf8mb4 
	collate utf8mb4_unicode_ci
;

use nauticsoft;

drop table if exists Mitarbeiter;
create table Mitarbeiter (
	MA_ID int,
	Nachname char(255),
	Vorname char(255),
	Geburtsdatum date,
	Tagesarbeitszeit int,
	primary key(MA_ID)
);

drop table if exists Fehlzeit;
create table Fehlzeit (
	FZ_ID int,
	MA_ID int,
	Von_Datum date,
	Bis_Datum date,
	Grund char(255),
	Fehltage int,
	primary key(FZ_ID),
	foreign key(MA_ID) references Mitarbeiter(MA_ID)
);

insert 
	into Mitarbeiter(MA_ID, Nachname, Vorname, Geburtsdatum, Tagesarbeitszeit)
	values( 811, "Müller", "Jens", 1982-14-04, 8 )
;;;

insert 
	into Mitarbeiter(MA_ID, Nachname, Vorname, Geburtsdatum, Tagesarbeitszeit)
	values( 812, "Scholz", "Birgin", 1964-23-08, 4 )
;;;

insert 
	into Mitarbeiter(MA_ID, Nachname, Vorname, Geburtsdatum, Tagesarbeitszeit)
	values( 815, "Schmidt", "Ulrich", 1957-11-02, 8 )
;;;

insert 
	into Mitarbeiter(MA_ID, Nachname, Vorname, Geburtsdatum, Tagesarbeitszeit)
	values( 817, "Storck", "Hans", 1990-14-11, 6 )
;;;

insert 
	into Mitarbeiter(MA_ID, Nachname, Vorname, Geburtsdatum, Tagesarbeitszeit)
	values( 841, "Ullmann", "Franz", 1959-21-12, 8 )
;;;

insert 
	into Mitarbeiter(MA_ID, Nachname, Vorname, Geburtsdatum, Tagesarbeitszeit)
	values( 902, "Sorge", "Susanne", 1952-02-03, 8 )
;;;

insert 
	into Mitarbeiter(MA_ID, Nachname, Vorname, Geburtsdatum, Tagesarbeitszeit)
	values( 904, "Wanghul", "Whanzugul", 1952-02-03, 8 )
;;;

insert 
	into Fehlzeit(FZ_ID, MA_ID, Von_Datum, Bis_Datum, Grund, Fehltage)
	values( 1, 811, 2017-18-04, 2017-23-04, "Urlaub", 4 )
;;;

insert 
	into Fehlzeit(FZ_ID, MA_ID, Von_Datum, Bis_Datum, Grund, Fehltage)
	values( 2, 902, 2017-18-04, 2017-08-05, "Krank", 14 )
;;;

insert 
	into Fehlzeit(FZ_ID, MA_ID, Von_Datum, Bis_Datum, Grund, Fehltage)
	values( 3, 811, 2017-19-06, 2017-20-06, "Krank", 2 )
;;;

insert 
	into Fehlzeit(FZ_ID, MA_ID, Von_Datum, Bis_Datum, Grund, Fehltage)
	values( 4, 811, 2017-17-11, 2017-17-11, "Urlaub", 1 )
;;;

insert 
	into Fehlzeit(FZ_ID, MA_ID, Von_Datum, Bis_Datum, Grund, Fehltage)
	values( 5, 904, 2017-31-12, 2017-31-12, "Urlaub", 1 )
;;;

insert 
	into Fehlzeit(FZ_ID, MA_ID, Von_Datum, Bis_Datum, Grund, Fehltage)
	values( 6, 904, 2018-01-01, 2018-09-01, "Urlaub", 6 )
;;;










