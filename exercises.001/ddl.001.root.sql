# database
drop database if exists sqlexcdb;
create database if not exists sqlexcdb character set utf8 collate utf8_general_ci;	

# the tables
drop table if exists sqlexcdb.timezone;
create table if not exists sqlexcdb.timezone (
	id int not null auto_increment primary key,
	label varchar(128),
	abbr varchar(255),
	offset decimal(4,1),
	description varchar(255),
	unique(label)
);

drop table if exists sqlexcdb.mimetype;
create table if not exists sqlexcdb.mimetype (
	id int not null auto_increment primary key,
	title varchar(128),
	description varchar(255),
	unique(title)
);

drop table if exists sqlexcdb.asset;
create table if not exists sqlexcdb.asset (
	id int not null auto_increment primary key,
	title varchar(255),
	description varchar(255),
	path varchar(255),
	mimetype_id int,
	foreign key (mimetype_id) references sqlexcdb.mimetype(id)
);

drop table if exists sqlexcdb.artist;
create table if not exists sqlexcdb.artist (
	id int not null auto_increment primary key,
	identification varchar(255),
	description varchar(255)
	# unique(identification)
);

drop table if exists sqlexcdb.asset_to_artist;
create table if not exists sqlexcdb.asset_to_artist (
	asset_id int,
	artist_id int,
	meta varchar(255),
	title varchar(255),
	description varchar(255),
	foreign key (asset_id) references sqlexcdb.asset(id),
	foreign key (artist_id) references sqlexcdb.artist(id),
	unique(asset_id, artist_id)			
);

drop table if exists sqlexcdb.arelease;
create table if not exists sqlexcdb.arelease (
	id int not null auto_increment primary key,
	title varchar(255),
	description varchar(255),
	rdate_date datetime,
	rdate_timezone_id int,
	foreign key (rdate_timezone_id) references sqlexcdb.timezone(id)
	# unique(title)
);

drop table if exists sqlexcdb.release_to_artist;
create table if not exists sqlexcdb.release_to_artist (
	release_id int,
	artist_id int,
	foreign key (release_id) references sqlexcdb.arelease(id),
	foreign key (artist_id) references sqlexcdb.artist(id),
	unique(release_id, artist_id)
);

drop table if exists sqlexcdb.asset_to_release;
create table if not exists sqlexcdb.asset_to_release (
	asset_id int,
	release_id int,
	meta varchar(255),
	title varchar(255),
	description varchar(255),
	foreign key (asset_id) references sqlexcdb.asset(id),
	foreign key (release_id) references sqlexcdb.arelease(id),
	unique(asset_id, release_id)
);

## procedures
drop procedure if exists sqlexcdb.select_artist;
delimiter :::
create procedure sqlexcdb.select_artist (
		i_identification varchar(255)
	)
	begin
		select * from sqlexcdb.artist where identification like i_identification;
	end
:::
delimiter ;

drop procedure if exists sqlexcdb.init_artist;
delimiter :::
create procedure sqlexcdb.init_artist (
		i_identification varchar(255),
		i_description varchar(255)
	)
	begin
		insert into sqlexcdb.artist (identification, description)
			values(i_identification, i_description)
		;
		select last_insert_id();		
	end
:::
delimiter ;

drop procedure if exists sqlexcdb.init_release;
delimiter :::
create procedure sqlexcdb.init_release (
		i_title varchar(255),
		i_description varchar(255),
		i_rdate_date datetime,
		i_rdate_timezone_id int
	)
	begin
		insert into sqlexcdb.arelease (title, description, rdate_date, rdate_timezone_id)
			values(i_title, i_description, i_rdate_date, i_rdate_timezone_id)
		;
		select last_insert_id();		
	end
:::
delimiter ;

drop procedure if exists sqlexcdb.link_release_to_artist;
delimiter :::
create procedure sqlexcdb.link_release_to_artist (
		i_release_id int,
		i_artist_id int
	)
	begin
		insert into sqlexcdb.release_to_artist (release_id, artist_id)
			values(i_release_id, i_artist_id)
		;
		select last_insert_id();
	end
:::
delimiter ;

drop procedure if exists sqlexcdb.init_asset;
delimiter :::
create procedure sqlexcdb.init_asset (
		i_title varchar(128),
		i_description varchar(255),
		i_path varchar(255),
		i_mimetype_id int
	)
	begin
		insert into sqlexcdb.asset (title, description, path, mimetype_id)
			values(i_title, i_description, i_path, i_mimetype_id)
		;
		select last_insert_id();		
	end
:::
delimiter ;

drop procedure if exists sqlexcdb.link_asset_to_artist;
delimiter :::
create procedure sqlexcdb.link_asset_to_artist (
		i_asset_id int,
		i_artist_id int,
		i_meta varchar(255),
		i_title varchar(255),
		i_description varchar(255)
	)
	begin
		insert into sqlexcdb.asset_to_artist (asset_id, artist_id, meta, title, description)
			values(i_asset_id, i_artist_id, i_meta, i_title, i_description)
		;
		select last_insert_id();		
	end
:::
delimiter ;

drop procedure if exists sqlexcdb.link_asset_to_release;
delimiter :::
create procedure sqlexcdb.link_asset_to_release (
		i_asset_id int,
		i_release_id int,
		i_meta varchar(255),
		i_title varchar(255),
		i_description varchar(255)
	)
	begin
		insert into sqlexcdb.asset_to_release (asset_id, release_id, meta, title, description)
			values(i_asset_id, i_release_id, i_meta, i_title, i_description)
		;
		select last_insert_id();		
	end
:::
delimiter ;

drop procedure if exists sqlexcdb.init_mimetype;
delimiter :::
create procedure sqlexcdb.init_mimetype (
		i_title varchar(128),
		i_description varchar(255)
	)
	begin
		insert into sqlexcdb.mimetype (title, description)
			values(i_title, i_description)
		;
		select last_insert_id();		
	end
:::
delimiter ;

drop procedure if exists sqlexcdb.init_timezone;
delimiter :::
create procedure sqlexcdb.init_timezone (
		i_label varchar(255),
		i_abbr varchar(255),
		i_offset decimal(4,1),
		i_description varchar(255)
	)
	begin
		insert into sqlexcdb.timezone (label, abbr, offset, description)
			values(i_label, i_abbr, i_offset, i_description)
		;
		select last_insert_id();		
	end
:::
delimiter ;

drop procedure if exists sqlexcdb.select_timezone_id;
delimiter :::
create procedure sqlexcdb.select_timezone_id (
		i_label varchar(128)
	)
	begin
		select id from sqlexcdb.timezone where label = i_label;
	end
:::
delimiter ;

drop procedure if exists sqlexcdb.select_mimetype_id;
delimiter :::
create procedure sqlexcdb.select_mimetype_id (
		i_title varchar(128)
	)
	begin
		select id from sqlexcdb.mimetype where title = i_title;
	end
:::
delimiter ;

drop procedure if exists sqlexcdb.select_assets_by_release_id;
delimiter :::
create procedure sqlexcdb.select_assets_by_release_id (
		i_release_id int
	)
	begin
		select asset.title, asset.path 
			from asset, asset_to_release
				where asset.id = asset_to_release.asset_id
					and asset_to_release.release_id = i_release_id;
	end
:::
delimiter ;

drop procedure if exists sqlexcdb.select_assets_by_artist_id;
delimiter :::
create procedure sqlexcdb.select_assets_by_artist_id (
		i_artist_id int
	)
	begin
		select asset.title, asset.path, release_to_artist.release_id
			from artist, release_to_artist, asset_to_release, asset
				where artist.id = release_to_artist.artist_id
					and release_to_artist.release_id = asset_to_release.release_id
					and asset.id = asset_to_release.asset_id
					and artist.id = i_artist_id;
	end
:::
delimiter ;

# clients
drop user if exists 'liberot'@'localhost';
create user if not exists 'liberot'@'localhost' identified by 'password';
grant execute on procedure sqlexcdb.select_artist to 'liberot'@'localhost';
grant execute on procedure sqlexcdb.init_artist to 'liberot'@'localhost';
grant execute on procedure sqlexcdb.init_release to 'liberot'@'localhost';
grant execute on procedure sqlexcdb.link_release_to_artist to 'liberot'@'localhost';
grant execute on procedure sqlexcdb.init_asset to 'liberot'@'localhost';
grant execute on procedure sqlexcdb.link_asset_to_artist to 'liberot'@'localhost';
grant execute on procedure sqlexcdb.link_asset_to_release to 'liberot'@'localhost';
grant execute on procedure sqlexcdb.init_mimetype to 'liberot'@'localhost';
grant execute on procedure sqlexcdb.init_timezone to 'liberot'@'localhost';
grant execute on procedure sqlexcdb.select_timezone_id to 'liberot'@'localhost';
grant execute on procedure sqlexcdb.select_mimetype_id to 'liberot'@'localhost';
grant execute on procedure sqlexcdb.select_assets_by_release_id to 'liberot'@'localhost';
grant execute on procedure sqlexcdb.select_assets_by_artist_id to 'liberot'@'localhost';

# flushi
flush privileges;


