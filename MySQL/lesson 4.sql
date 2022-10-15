CREATE DATABASE vk;
USE vk;

create table user (
id bigint unsigned primary key auto_increment,
firstname varchar(100) not null,
last_name varchar(100) not null,
email varchar(100) unique not null,
phone char(11) not null,
password_hash char(65) default null,
created_at datetime not null default current_timestamp
);

-- Вывод имен в алфавитном порядке без повторений 
select distinct firstname from user order by firstname;

-- Отмечаем несовершеннолетних неактивными
alter table profiles add column is_active bool default true;

update profiles
set is_active = false
where timestampdiff(year, birthday, current_timestamp) < 18 and user_id > 0;

select * from profiles where timestampdiff(year, birthday, current_timestamp) < 18;

------------------------------------------------------------------------------------

insert into user values (default, "Boris", "Prohorov", "1234@gmail.com", "89574837584", default, default);
insert into user values (default, "Petr", "Korovin", "email@mail.ru", "89475837549", default, default);
insert into user values (default, "Olga", "Korovina", "email2@mail.ru", "89474837549", default, default);
insert into user values (default, "Vasiliy", "Anonimnyi", "vasya@mail.ru", "89473949204", "123", default);
insert into user values (default, "Petr", "Korovkin", "korovpetr@mail.ru", "89212344554", default, default);
insert into user values (default, "Igor", "Smolov", "igorek@mail.ru", "89984323399", default, default);
insert into user values (default, "Anon", "Anon", "anonim@mail.ru", "89531344434", default, default);
insert into user values (default, "Sasha", "Voronova", "sanya@gmail.com", "89994342212", default, default);
insert into user values (default, "Ivan", "Krotov", "12345@mail.ru", "89123499816", default, default);
insert into user values (default, "Stas", "Ananiev", "stasik23@mail.ru", "89475837555", default, default);

select * from profiles;

create table profiles(
user_id bigint unsigned primary key,
gender enum ('f', 'm', 'x') not null,
birthday date not null,
photo_id bigint unsigned,
city varchar(100),
country varchar(100) not null,
foreign key (user_id) references user(id)
);

insert into profiles values (1, 'm', '1996-10-12', null, "Moskow", "Russia");
insert into profiles values (2, 'm', '1998-12-21', null, "Moskow", "Russia");
insert into profiles values (4, 'x', '2002-10-12', null, null, "Russia");
insert into profiles values (5, 'm', '2000-11-06', null, "SPB", "Russia");
insert into profiles values (6, 'm', '1996-02-19', null, null, "Russia");
insert into profiles values (8, 'm', '2016-02-19', null, null, "Russia", default);

create table messages (
id serial primary key,
from_user_id bigint unsigned not null,
to_user_id bigint unsigned not null,
txt text not null,
is_delivered bool default false,
created_at datetime not null default now(),
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
foreign key (from_user_id) references user(id),
foreign key (to_user_id) references user(id)
);

INSERT messages VALUES (DEFAULT, 1, 2, 'hi!', DEFAULT, DEFAULT, DEFAULT);
INSERT messages VALUES (DEFAULT, 1, 2, 'Vasya!', DEFAULT, DEFAULT, DEFAULT);
INSERT messages VALUES (DEFAULT, 2, 1, 'hi!', DEFAULT, DEFAULT, DEFAULT);

-- Создаем сообщение из будущего

INSERT messages VALUES (DEFAULT, 2, 1, 'hi!', DEFAULT, '2030-12-01', DEFAULT);
INSERT messages VALUES (DEFAULT, 2, 1, 'hi!', DEFAULT, '2022-09-24', DEFAULT);

-- Удаляем сообщение из будущего

delete from messages where created_at > now();

-- Или

delete from messages where timestampdiff(second, created_at, now()) < 0 and id > 0;

select * from messages;

CREATE TABLE friend_requests(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	accepted BOOL DEFAULT FALSE,
	PRIMARY KEY (from_user_id, to_user_id),
	CONSTRAINT fk_friend_requests_from_user_id FOREIGN KEY (from_user_id) REFERENCES user (id),
	CONSTRAINT fk_friend_requests_to_user_id FOREIGN KEY (to_user_id) REFERENCES user (id)
);

INSERT friend_requests VALUES (1, 2, DEFAULT);
INSERT friend_requests VALUES (2, 1, DEFAULT);
INSERT friend_requests VALUES (1, 5, DEFAULT);
INSERT friend_requests VALUES (2, 6, DEFAULT);

CREATE TABLE communities (
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL,
	description VARCHAR(255),
	admin_id BIGINT UNSIGNED NOT NULL,
	INDEX (name),
	FOREIGN KEY (admin_id) REFERENCES user (id)	
);

INSERT communities VALUES (DEFAULT, 'Number 1', '1 communities', 1);
INSERT communities VALUES (DEFAULT, 'Number 2', '2 communities', 7);

CREATE TABLE communities_users (
	community_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (community_id, user_id),
	FOREIGN KEY (community_id) REFERENCES communities (id),
	FOREIGN KEY (user_id) REFERENCES user (id)
);

INSERT communities_users VALUES (1, 2, DEFAULT);
INSERT communities_users VALUES (2, 6, DEFAULT);

CREATE TABLE reaction_types(
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
reaction_type VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO reaction_types VALUES (DEFAULT, "LIKE");
INSERT INTO reaction_types VALUES (DEFAULT, "UNLIKE");
INSERT INTO reaction_types VALUES (DEFAULT, "WOW");
INSERT INTO reaction_types VALUES (DEFAULT, "AWFUL");

CREATE TABLE reactions(
from_user_id BIGINT UNSIGNED NOT NULL,
to_user_id BIGINT UNSIGNED NOT NULL,
reaction_types_id INT UNSIGNED NOT NULL,
foreign key (reaction_types_id) references reaction_types (id),
foreign key (from_user_id) references user (id),
foreign key (to_user_id) references user (id)
);

insert into reactions values (1, 2, 1);
insert into reactions values (2, 1, 3);
insert into reactions values (1, 2, 2);

create table statuses(
id serial primary key,
owner_id bigint unsigned not null,
txt text not null,
created_at datetime not null default now(),
foreign key (owner_id) references user (id)
);

insert into statuses values (default, 1, "It's my birthday", default);
insert into statuses values (default, 2, "Happy birthday, Boris!", default);

CREATE TABLE media_types(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO media_types VALUES (DEFAULT, 'изображение');
INSERT INTO media_types VALUES (DEFAULT, 'музыка');
INSERT INTO media_types VALUES (DEFAULT, 'документ');

CREATE TABLE media (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	file_name VARCHAR(255) NOT NULL,
	file_size BIGINT UNSIGNED,
	media_types_id INT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT NOW(),
	FOREIGN KEY (user_id) REFERENCES user (id),
	FOREIGN KEY (media_types_id) REFERENCES media_types (id)
);

INSERT media VALUES (DEFAULT, 1, 'test1.jpg', 100, 1, DEFAULT);
INSERT media VALUES (DEFAULT, 1, 'test2.jpg', 120, 1, DEFAULT);
INSERT media VALUES (DEFAULT, 7, 'test3.mp3', 100, 2, DEFAULT);
INSERT media VALUES (DEFAULT, 5, 'test4.docx', 120, 3, DEFAULT);

select * from reaction_types;
select * from reactions;
select * from statuses;
select * from user;

-- Задание к уроку 5

update user
set created_at = now()
where created_at is null and id > 0;

update user
set updated_at = now()
where updated_at is null and id > 0;

-- Задание 5.2

alter table user modify created_at varchar(100);

update user
set created_at = '20.10.2017 8:10'
where id > 0;

alter table user add created_at_datetype datetime not null default current_timestamp;

update user
set created_at_datetype = str_to_date(created_at, '%e.%m.%Y %H:%i')
where id > 0;

alter table user drop created_at;
alter table user rename column created_at_datetype to created_at;

-- Задача 5.3

create table storehouses_products(
id serial primary key,
name varchar(100) not null,
value bigint not null
);

insert into storehouses_products values (default, "Кружки", 50);
insert into storehouses_products values (default, "Ложки", 52);
insert into storehouses_products values (default, "Ножи", 5);
insert into storehouses_products values (default, "Тарелки", 0);
insert into storehouses_products values (default, "Чашки", 0);

SELECT * FROM storehouses_products ORDER BY value = 0, value;

-- Задача 5.5

 SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY catalogs.id = 5 desc, catalogs.id = 1 desc, catalogs.id = 2 desc;
 
 -- Агрегация ----------------------------------------------------------
 -- Задача 1
 
 select round(avg(timestampdiff(year, birthday, now()))) as avg_age from profiles;
 
select dayname(concat(year(now()), substring(birthday, 5, 10))) as day_name, count(*) as count_of_birthday
from profiles
group by day_name
order by count_of_birthday;
 
select * from storehouses_products;

select round(exp(sum(ln(value)))) from storehouses_products;

select value from storehouses_products;
