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