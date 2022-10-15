create database lesson_7;
use lesson_7;

create table flights (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    city_from VARCHAR(50) NOT NULL,
    city_to VARCHAR(50) NOT NULL
);
    
create table cities (
    label VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL
);    

INSERT INTO 
	flights (city_from, city_to) 
VALUES
	('moscow', 'omsk'),
    ('novgorod', 'kazan'),
    ('irkutsk', 'moscow'),
    ('omsk', 'irkutsk'),
    ('moscow', 'kazan');
    
INSERT INTO 
	cities (label, name) 
VALUES
	('moscow', 'Москва'),
    ('irkutsk', 'Иркутск'),
    ('novgorod', 'Новгород'),
    ('kazan', 'Казань'),
    ('omsk', 'Омск');
    
SELECT * from cities;
SELECT * from flights;

select id, a.name as 'from', cities.name as 'to' from
	(select * from flights join cities
		where flights.city_from = cities.label) as a
	join cities
		where a.city_to = cities.label
order by id;
