# database
drop database if exists sqlexcdb2nd;
create database if not exists sqlexcdb2nd character set utf8 collate utf8_general_ci;

# tables
drop table if exists sqlexcdb2nd.kunde;
create table if not exists sqlexcdb2nd.kunde (
	kunde_id int not null auto_increment primary key,
	firma char(255),
	strasse char(255),
	plz char(255),
	ort char(255)
);

drop table if exists sqlexcdb2nd.hersteller;
create table if not exists sqlexcdb2nd.hersteller (
	hersteller_id int not null auto_increment primary key,
	firma char(255)
);

drop table if exists sqlexcdb2nd.rechnung;
create table if not exists sqlexcdb2nd.rechnung (
	rechnung_id int not null auto_increment primary key,
	kunde_id int,
	rechnungsdatum datetime,
	foreign key (kunde_id) references sqlexcdb2nd.kunde(kunde_id)
);

drop table if exists sqlexcdb2nd.artikel;
create table if not exists sqlexcdb2nd.artikel (
	artikel_id int not null auto_increment primary key,
	hersteller_id int,
	bezeichnung char(255),
	listenpreis decimal(10,2),
	foreign key (hersteller_id) references sqlexcdb2nd.hersteller(hersteller_id)
);

drop table if exists sqlexcdb2nd.position;
create table if not exists sqlexcdb2nd.position (
	rechnung_id int,
	artikel_id int,
	menge int,
	verkaufs_einzelpreis decimal(10,2),
	foreign key(rechnung_id) references sqlexcdb2nd.rechnung(rechnung_id),
	foreign key(artikel_id) references sqlexcdb2nd.artikel(artikel_id),
	primary key(rechnung_id, artikel_id)
);

insert into sqlexcdb2nd.kunde(firma) values('Whagulu Medien AG');
insert into sqlexcdb2nd.kunde(firma) values('Batlas Gratlas Group');
insert into sqlexcdb2nd.kunde(firma) values('Why GmbH');

insert into sqlexcdb2nd.hersteller(firma) values('ABC-Gesund AG');
insert into sqlexcdb2nd.hersteller(firma) values('Zeppelin Pharma AG');
insert into sqlexcdb2nd.hersteller(firma) values('FeelGood-Partner OHG');
insert into sqlexcdb2nd.hersteller(firma) values('Loser & Vaul GmbH');

insert into sqlexcdb2nd.artikel(hersteller_id, bezeichnung, listenpreis) values(1, 'Aspiran Forte', 10.91);
insert into sqlexcdb2nd.artikel(hersteller_id, bezeichnung, listenpreis) values(1, 'Zakoran Pasté', 113.00);
insert into sqlexcdb2nd.artikel(hersteller_id, bezeichnung, listenpreis) values(1, 'Lifetime Longus', 22.11);
insert into sqlexcdb2nd.artikel(hersteller_id, bezeichnung, listenpreis) values(2, 'Cardioshock 2.0', 7.93);
insert into sqlexcdb2nd.artikel(hersteller_id, bezeichnung, listenpreis) values(2, 'Kanublis manublis', 17.03);
insert into sqlexcdb2nd.artikel(hersteller_id, bezeichnung, listenpreis) values(3, 'Katerstop', 1.22);
insert into sqlexcdb2nd.artikel(hersteller_id, bezeichnung, listenpreis) values(3, 'Frojljangle', 81.00);
insert into sqlexcdb2nd.artikel(hersteller_id, bezeichnung, listenpreis) values(3, 'Xanthupas Dragee', 11.11);
insert into sqlexcdb2nd.artikel(hersteller_id, bezeichnung, listenpreis) values(4, 'Rafulesan Depot', 121.99);

insert into sqlexcdb2nd.rechnung(kunde_id) values(1);
insert into sqlexcdb2nd.position(rechnung_id, artikel_id, menge, verkaufs_einzelpreis) values(1, 1, 12, 13.00);
insert into sqlexcdb2nd.position(rechnung_id, artikel_id, menge, verkaufs_einzelpreis) values(1, 2, 1, 200.00);
insert into sqlexcdb2nd.position(rechnung_id, artikel_id, menge, verkaufs_einzelpreis) values(1, 3, 250, 25.00);
insert into sqlexcdb2nd.position(rechnung_id, artikel_id, menge, verkaufs_einzelpreis) values(1, 4, 5, 10.99);
insert into sqlexcdb2nd.position(rechnung_id, artikel_id, menge, verkaufs_einzelpreis) values(1, 5, 12, 29.99);

insert into sqlexcdb2nd.rechnung(kunde_id) values(2);
insert into sqlexcdb2nd.position(rechnung_id, artikel_id, menge, verkaufs_einzelpreis) values(2, 1, 1, 15.00);
insert into sqlexcdb2nd.position(rechnung_id, artikel_id, menge, verkaufs_einzelpreis) values(2, 2, 23, 200.91);
insert into sqlexcdb2nd.position(rechnung_id, artikel_id, menge, verkaufs_einzelpreis) values(2, 3, 1, 25.00);


