/*
	FIAE 2011 Wi GA 1 AE 
 */

update 
	Fehlzeit
	set
		Fehlzeit.Bis_Datum = 2017-18-11,
		Fehlzeit.Grund = "Dienstreise",
		Fehlzeit.Fehltage = 2
	where
		Fehlzeit.FZ_ID = 4
;;;

select 
	Mitarbeiter.MA_ID,
	Mitarbeiter.Nachname,
	SUM(Fehlzeit.Fehltage)
from
	Mitarbeiter
	left join Fehlzeit on Mitarbeiter.MA_ID = Fehlzeit.MA_ID
where
	Fehlzeit.Grund = "Urlaub"
	and
		Fehlzeit.Von_Datum >= 2017-01-01
	and
		Fehlzeit.Bis_Datum <= 2017-31-12
group by
	Mitarbeiter.MA_ID, 
	Mitarbeiter.Nachname, 
	Mitarbeiter.Vorname
;;;

drop table Fehlzeit;
;;;

create table Fehlzeitgrund (
	Grund_ID int,
	Grund char(255),
	primary key(Grund_ID)
);
describe Fehlzeitgrund;
;;; 

drop table if exists Fehlzeit;
create table Fehlzeit(
	Fehlzeit.MA_ID integer,
	Fehlzeit.Von_Datum date,
	Fehlzeit.Bis_Datum date,
	Fehlzeit.Grund_ID int,
	Fehlzeit.Fehltage int,
	primary key Fehlzeit(MA_ID),
	foreign key Fehlzeit(Grund_ID) references Fehlzeitgrund(Grund_ID)
);
describe Fehlzeit;
;;;








