/*
	FIAE 2018 So GA 1 AE 
 */

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
