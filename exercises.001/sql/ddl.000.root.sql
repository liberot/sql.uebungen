create database if not exists sqlexercise;

drop table if exists sqlexercise.testtable;
create table if not exists sqlexercise.testtable (
	id int not null auto_increment primary key,
	data varchar(255)
);

drop user if exists 'liberot'@'localhost';
create user if not exists 'liberot'@'localhost' identified by 'password';
grant all privileges on sqlexercise.testtable to 'liberot'@'localhost' identified by 'password';

flush privileges;