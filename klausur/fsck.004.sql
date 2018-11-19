use klausur;

select
	a.angebotsnummer,
	k.nachname,
	k.firma,
	art.bezeichnung,
	art.listenpreis,
	p.menge,
	art.listenpreis *p.menge as netto,
	round((art.listenpreis *p.menge) /100 *19, 2) as '19% USt.',
	round((art.listenpreis *p.menge) +((art.listenpreis *p.menge) /100 *19), 2) as brutto
from
	angebot a,
	kunde k,
	position p,
	artikel art
where
	a.kundennummer = k.kundennummer
	and a.erstellungsdatum >= str_to_date('2000-10-01', '%Y-%m-%d')
	and a.erstellungsdatum <= str_to_date('2022-10-31', '%Y-%m-%d')
	and a.angebotsnummer = p.angebotsnummer
	and p.artikelnummer = art.artikelnummer
order by
	a.angebotsnummer
;

select
	a.angebotsnummer,
	a.erstellungsdatum,
	k.vorname, 
	k.nachname,
	k.firma,
	sum(art.listenpreis *p.menge) as gesamt
from
	angebot a,
	kunde k,
	position p,
	artikel art
where
	a.kundennummer = k.kundennummer
	and a.erstellungsdatum >= str_to_date('2000-10-01', '%Y-%m-%d')
	and a.erstellungsdatum <= str_to_date('2022-10-31', '%Y-%m-%d')
	and a.angebotsnummer = p.angebotsnummer
	and p.artikelnummer = art.artikelnummer
group by
	a.angebotsnummer
;

# set session time_zone = '+2:00';
# select str_to_date('2109-10-01 01:00:00', '%Y-%m-%d %r');
select
	a.angebotsnummer,
	a.erstellungsdatum,
	k.vorname, 
	k.nachname,
	k.firma,
	sum(art.listenpreis *p.menge) as gesamt
from
	angebot a
inner join 
	kunde k on a.kundennummer = k.kundennummer
inner join
	position p on a.angebotsnummer = p.angebotsnummer
inner join
	artikel art on p.artikelnummer = art.artikelnummer
where
	a.erstellungsdatum >= str_to_date('2010-10-01', '%Y-%m-%d')
	and a.erstellungsdatum <= str_to_date('2017-01-01', '%Y-%m-%d')
group by
	a.angebotsnummer
;
