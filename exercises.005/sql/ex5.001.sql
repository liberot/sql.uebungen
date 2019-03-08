/*
	Database of FIAE 2018 So GA 1 AE 
 */


drop database if exists eco_pharmalog;
create database eco_pharmalog 
	character set utf8mb4 
	collate utf8mb4_unicode_ci
;

use eco_pharmalog;

drop table if exists Kunde;
create table Kunde (
	Kunde_ID int,
	Firma char(255),
	Strasse char(255),
	Plz char(255),
	Ort char(255),
	primary key(Kunde_ID)
);

drop table if exists Rechnung;
create table Rechnung (
	Rechnung_ID int,
	Kunde_ID int,
	RechnungsDatum date,
	primary key(Rechnung_ID, Kunde_ID),
	foreign key(Kunde_ID) references Kunde(Kunde_ID)
);

drop table if exists Hersteller;
create table Hersteller (
	Hersteller_ID int,
	Firma char(255),
	primary key(Hersteller_ID)
);

drop table if exists Artikel;
create table Artikel (
	Artikel_ID int,
	Hersteller_ID int,
	Bezeichnung char(255),
	Listenpreis decimal(10,2),
	primary key(Artikel_ID),
	foreign key(Hersteller_ID) references Hersteller(Hersteller_ID)
);

drop table if exists Position;
create table Position (
	Rechnung_ID int,
	Artikel_ID int,
	Menge int,
	Verkaufs_Einzelpreis decimal(10,2),
	primary key(Rechnung_ID, Artikel_ID),
	foreign key(Rechnung_ID) references Rechnung(Rechnung_ID),
	foreign key(Artikel_ID) references Artikel(Artikel_ID)
);

insert into Kunde
	(Kunde_ID, Firma, Strasse, Plz, Ort)
	values(0, "Firma1st", "Strasse1st", "Plz1st", "Ort1st")
;

insert into Hersteller
	(Hersteller_ID, Firma)
	values(0, "Hersteller1st")
;

insert into Hersteller
	(Hersteller_ID, Firma)
	values(1, "Hersteller2nd")
;

insert into Artikel
	(Artikel_ID, Hersteller_ID, Bezeichnung, Listenpreis)
	values(0, 0, "Bezeichnung1st", "10.00")
;

insert into Artikel
	(Artikel_ID, Hersteller_ID, Bezeichnung, Listenpreis)
	values(1, 0, "Bezeichnung2nd", "11.00")
;

insert into Artikel
	(Artikel_ID, Hersteller_ID, Bezeichnung, Listenpreis)
	values(2, 0, "Bezeichnung2nd", "12.00")
;

insert into Rechnung
	(Rechnung_ID, Kunde_ID, RechnungsDatum)
	values(0, 0, "2007-01-12")
;

insert into Rechnung
	(Rechnung_ID, Kunde_ID, RechnungsDatum)
	values(1, 0, "2007-01-10")
;

insert into Rechnung
	(Rechnung_ID, Kunde_ID, RechnungsDatum)
	values(2, 0, "2007-01-7")
;

insert into Position
	(Rechnung_ID, Artikel_ID, Menge, Verkaufs_Einzelpreis)
	value(0, 0, 10, "10.12")
;

insert into Position
	(Rechnung_ID, Artikel_ID, Menge, Verkaufs_Einzelpreis)
	value(0, 1, 10, "20.22")
;

insert into Position
	(Rechnung_ID, Artikel_ID, Menge, Verkaufs_Einzelpreis)
	value(0, 2, 10, "30.12")
;

SELECT
	Kunde.Kunde_ID,
	Kunde.Firma,
	COUNT(Rechnung.Rechnung_ID) AS Anzahl
FROM
	Kunde
	LEFT JOIN
		Rechnung
		ON Kunde.Kunde_ID = Rechnung.Kunde_ID
WHERE
	YEAR(Rechnung.RechnungsDatum) = 2007
GROUP BY 
	Kunde.Kunde_ID, 
	Kunde.Firma
ORDER BY
	COUNT(Rechnung.Rechnung_ID) DESC,
	Kunde.Firma
;;;

UPDATE 
	Artikel, Hersteller
SET
	Artikel.Listenpreis = Artikel.Listenpreis *1.45
WHERE
	Artikel.Hersteller_ID = Hersteller.Hersteller_ID
	AND
	Hersteller.Firma = "Hersteller1st"
;;;

SELECT
	*
FROM 
	Artikel
;;;

SELECT
	Kunde.Kunde_ID, Firma, Artikel.Bezeichnung,
	SUM(Position.Menge * Position.Verkaufs_Einzelpreis) AS Umsatz
FROM
	Kunde
	LEFT JOIN Rechnung ON Kunde.Kunde_ID = Rechnung.Kunde_ID
	LEFT JOIN Position ON Rechnung.Rechnung_ID = Position.Rechnung_ID
	LEFT JOIN Artikel ON Position.Artikel_ID = Artikel.Artikel_ID
GROUP BY
	Kunde.Kunde_ID, Firma, Artikel.Bezeichnung
;;;

CREATE TABLE Artikelgruppe(
	Artikelgruppe_ID INTEGER PRIMARY KEY,
	Artikelgruppenbezeichnung CHAR(50)
);;;

describe Artikelgruppe;
;;;;

ALTER TABLE Artikel
	ADD COLUMN Artikelgruppe_ID INTEGER,
	ADD FOREIGN KEY(Artikelgruppe_ID)
		REFERENCES Artikelgruppe(Artikelgruppe_ID)
;;;

describe Artikel;
;;;
