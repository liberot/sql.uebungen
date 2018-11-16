select
	a.angebotsnummer,
	a.erstellungsdatum,
	k.vorname, 
	k.nachname,
	k.firma,
	sum(art.listenpreis *p.menge)
from
	kunde k,
	angebot a,
	position p,
	artikel art
where
	a.erstellungsdatum >= str_to_date('2010-10-01', '%Y-%m-%d')
	and a.erstellungsdatum <= str_to_date('2022-10-31', '%Y-%m-%d')
	and a.kundennummer = k.kundennummer
	and a.angebotsnummer = p.angebotsnummer
	and p.artikelnummer = art.artikelnummer
group by
	a.angebotsnummer
;