select * from
	ausleihe a 
where 
	a.rueckgabedatum >= '2012-01-01';

select * from
	ausleihe a 
where 
	a.rueckgabedatum >= date_add('2012-01-01', interval 2 day);

select date_add('2012-01-01', interval 2 day);
select date_add(str_to_date('2012-01-01', '%Y-%m-%d'), interval 2 day);
select date('2012-01-01') +2;
select date_add(str_to_date('2012-01-01', '%Y-%m-%d'), interval +100 day);
select date_add(str_to_date('2012-01-01', '%Y-%m-%d'), interval -100 day);

select * from client;

select 
		c.familyname,
		c.name,
		a.hausnummer, 
		a.strasse,
		a.plz,
		a.ort,
		a.land 
	from 
		client c,
		address a, 
		ref_client_address r
	where
		r.address_id = a.address_id
	and
		r.client_id = c.client_id
	and
		c.client_id = 3;

set @d1st = str_to_date('2012-11-11', '%Y-%m-%d');
set @d2nd = str_to_date('2010-11-11', '%Y-%m-%d');

select @d1st, @d2nd, (@d1st -@d2nd);

set @d1st = str_to_date('2012-11-11', '%Y-%m-%d');
set @d2nd = str_to_date('2011-11-12', '%Y-%m-%d');

select @d1st, @d2nd, (@d1st -@d2nd);
select @d1st, @d2nd, timediff(@d1st, @d2nd);
select @d1st, @d2nd, datediff(@d1st, @d2nd);

