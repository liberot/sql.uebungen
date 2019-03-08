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
	foreign key(MA_ID) references Mitarbeiter.MA_ID
);


