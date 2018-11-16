select
	a.angebotsnummer,
	a.erstellungsdatum,
	k.vorname, 
	k.nachname,
	k.firma,
	sum(art.listenpreis *p.menge)
from
	angebot a,
	kunde k,
	position p,
	artikel art
where
	a.kundennummer = k.kundennummer
	and a.erstellungsdatum >= str_to_date('2010-10-01', '%Y-%m-%d')
	and a.erstellungsdatum <= str_to_date('2022-10-31', '%Y-%m-%d')
	and a.angebotsnummer = p.angebotsnummer
	and p.artikelnummer = art.artikelnummer
group by
	a.angebotsnummer
;