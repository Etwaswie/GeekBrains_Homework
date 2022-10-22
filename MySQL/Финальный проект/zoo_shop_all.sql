-- База данных магазина товаров для животных. Есть таблицы с товарами, покупателями, онлайн и офлайн покупками, продавцами и  т.д, всего 10 штук.

DROP DATABASE IF EXISTS zoo_store;
CREATE DATABASE zoo_store;
USE zoo_store;

DROP TABLE IF EXISTS categories;    
CREATE TABLE categories (
	category_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name varchar(100)
);

SELECT * from categories;
    
    
DROP TABLE IF EXISTS brands;    
CREATE TABLE brands (
	brand_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name varchar(50),
    country varchar(50)
);
    
SELECT * from brands;


DROP TABLE IF EXISTS items;
CREATE TABLE items (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name varchar(150),
    category_id INT,
    brand_id INT,
    amount BIGINT,
    price DECIMAL(5, 2),
    FOREIGN KEY (category_id)  REFERENCES categories (category_id),
    FOREIGN KEY (brand_id)  REFERENCES brands (brand_id)
    );
    
SELECT * from items;


DROP TABLE IF EXISTS clients;     
CREATE TABLE clients (
	client_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name varchar(150),
    phone VARCHAR(12),
    birthday DATE,
    bonus_card BIGINT,
    total_amount BIGINT
    );
    
SELECT * from clients;


DROP TABLE IF EXISTS purchases;  
CREATE TABLE purchases (
	purchase_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    client_id INT,
    payment_method ENUM ('Карта', 'Наличные'),
    date_of_purchase DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount_of_bonuses INT,
    seller_id INT NOT NULL,
    FOREIGN KEY (client_id)  REFERENCES clients (client_id),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

SELECT * from purchases;

alter TABLE purchases add COLUMN seller_id INT;
ALTER TABLE purchases MODIFY COLUMN seller_id INT NOT NULL;
ALTER TABLE purchases ADD FOREIGN KEY (seller_id) REFERENCES sellers(seller_id);
    
    
DROP TABLE IF EXISTS orders;      
CREATE TABLE orders (
	order_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    client_id INT,
    payment_method ENUM ('Карта', 'Наличные'),
    date_of_purchase DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount_of_bonuses INT,
	method_of_receiving ENUM ("Доставка", "Самовывоз"),
    FOREIGN KEY (client_id)  REFERENCES clients (client_id)
);  

SELECT * from orders;
    
    
DROP TABLE IF EXISTS items_in_order;      
CREATE TABLE items_in_order (
	items_in_order_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	order_id INT NOT NULL,
    item_id INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (item_id)  REFERENCES items (id),
    FOREIGN KEY (order_id)  REFERENCES orders (order_id)
);

SELECT * from items_in_order;


DROP TABLE IF EXISTS items_in_purchase;  
CREATE TABLE items_in_purchase (
	items_in_purchase_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	purchase_id INT NOT NULL,
    item_id INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (item_id)  REFERENCES items (id),
    FOREIGN KEY (purchase_id)  REFERENCES purchases (purchase_id)
);

SELECT * from items_in_purchase;


DROP TABLE IF EXISTS items_photo;  
CREATE TABLE items_photo (
	item_id INT NOT NULL PRIMARY KEY,
	photo_id INT NOT NULL,
    FOREIGN KEY (item_id)  REFERENCES items (id)
);

SELECT * from items_photo;


DROP TABLE IF EXISTS sellers;  
CREATE TABLE sellers (
	seller_id INT NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

SELECT * FROM sellers;    


-- Заполнение таблиц данными
INSERT INTO 
	categories (name) 
VALUES 
	("Сухие корма для кошек"),
    ("Влажные корма для кошек"),
    ("Сухие корма для собак"),
    ("Влажные корма для собак"),
    ("Игрушки для кошек"),
    ("Игрушки для собак"),
    ("Сухие корма для грызунов"),
    ("Сухие корма для рыб"),
    ("Сухие корма для птиц"),
    ("Лекарственные препараты"),
    ("Наполнители"),
    ("Витамины для кошек"),
    ("Витамины для собак");
    
INSERT INTO 
	sellers (seller_id, name)
VALUES 
	(1, "Федор Ситцев"),
	(2, "Ирина Молотова"),
	(3, "Константин Урюков"),
	(4, "Людмила Стародубцева"),
	(5, "София Килюкова"),
	(6, "Степан Рыков");
    
INSERT INTO 
	items_photo (item_id, photo_id) 
VALUES 
	(1, 1),
    (2, 2),
    (7, 3),
    (3, 4),
    (4, 5),
    (8, 6),
    (5, 7),
    (6, 8);    
    
INSERT INTO 
	items_in_purchase (purchase_id, item_id, amount) 
VALUES 
	(1, 3, 2),
    (1, 2, 1),
    (2, 1, 2),
    (3, 1, 2),
    (4, 6, 2),
    (5, 7, 2),
    (6, 4, 2),
    (7, 5, 2),
    (8, 8, 2),
    (9, 3, 2),
    (10, 10, 2),
    (11, 6, 2),
    (12, 1, 2),
    (13, 14, 24),
    (13, 15, 24);    
    
INSERT INTO 
	items_in_purchase (purchase_id, item_id, amount) 
VALUES 
	(1, 3, 2),
    (1, 2, 1),
    (2, 1, 2),
    (3, 1, 2),
    (4, 6, 2),
    (5, 7, 2),
    (6, 4, 2),
    (7, 5, 2),
    (8, 8, 2),
    (9, 3, 2),
    (10, 10, 2),
    (11, 6, 2),
    (12, 1, 2),
    (13, 14, 24),
    (13, 15, 24);
    
INSERT INTO 
	items_in_order (order_id, item_id, amount) 
VALUES 
	(1, 3, 2),
    (1, 2, 1),
    (2, 1, 2),
    (3, 1, 2),
    (4, 6, 2),
    (5, 7, 2),
    (6, 4, 2),
    (7, 5, 2),
    (8, 8, 2),
    (9, 3, 2),
    (10, 10, 2),
    (11, 6, 2),
    (12, 1, 2),
    (13, 14, 24),
    (13, 15, 24);
    
INSERT INTO 
	orders (client_id, payment_method, amount_of_bonuses, method_of_receiving) 
VALUES 
	(1, "Карта", 48, "Самовывоз"),
    (5, "Карта", 123, "Доставка"),
    (2, "Наличные", 7, "Самовывоз"),
    (19, "Карта", 34, "Самовывоз"),
    (17, "Карта", 11, "Доставка"),
    (20, "Карта", 44, "Самовывоз"),
    (6, "Карта", 12, "Доставка"),
    (4, "Наличные", 0, "Доставка"),
    (6, "Карта", 67, "Доставка");
    
INSERT INTO 
	purchases (client_id, payment_method, amount_of_bonuses, seller_id) 
VALUES 
	(18, "Карта", 48, 2),
    (19, "Карта", 45, 3),
    (1, "Наличные", 0, 3),
    (3, "Карта", 34, 6),
    (18, "Карта", 11, 4),
    (8, "Карта", 33, 1),
    (11, "Карта", 24, 3),
    (14, "Наличные", 0, 2),
    (15, "Карта", 66, 5);
    
INSERT INTO 
	clients (name, phone, birthday) 
VALUES 
	("Игорь Болохов", "+79723659171", "1975-12-16"),
    ("Анна Маркова", "+79324591001", "1999-07-03"),
    ("Анна Новикова", "+79495282662", "1999-07-03"),
    ("Николай Сотов", "+79495055703", "1999-07-03"),
    ("Борис Маликов", "+79495139721", "1999-07-03"),
    ("Константин Пронин", "+79495199246", "1999-07-03"),
    ("Владислава Тихомирова", "+79495538185", "1999-07-03"),
    ("Александр Малый", "+79495116262", "1999-07-03"),
    ("Павел Лозинский", "+79495758897", "1999-07-03"),
    ("Иван Липов", "+79495296053", "1999-07-03"),
    ("Анна Строкова", "+79495183272", "1999-07-03"),
    ("Алиса Степанова", "+79495853403", "1999-07-03"),
    ("Дмитрий Ростовцев", "+79495650240", "1999-07-03"),
    ("Эдуард Нилов", "+79495887420", "1999-07-03"),
    ("Людмила Сторожцева", "+79495546606", "1999-07-03"),
    ("Изольда Крюкова", "+79495659140", "1999-07-03"),
    ("Родион Московский", "+79495599535", "1999-07-03"),
    ("Александра Лозинская", "+79495533944", "1999-07-03"),
    ("Сергей Курукин", "+79495050181", "1999-07-03"),
    ("Валентина Носкова", "+79495491114", "1999-07-03");
    
INSERT INTO 
	brands (name, country) 
VALUES 
	("Royal Canin", "Франция"),
    ("Purina", "Россия"),
    ("AKANA", "Испания"),
    ("1st Choise", "Канада"),
    ("Зоогурман", "Россия"),
    ("Четвероногий гурман", "Россия"),
    ("Monge", "Италия"),
    ("Pronature", "Канада"),
    ("Schesir", "Франция"),
    ("Cat Chow", "Россия"),
    ("Versele Laga", "Испания"),
    ("ВАКА", "Россия"),
    ("Triol", "Россия"),
    ("Canagan", "Италия"),
    ("Friskies", "Россия");

INSERT INTO 
	items (name, category_id, brand_id, amount, price) 
VALUES 
	("Корм PRO PLAN для взрослых кошек с чувствительным пищеварением, 10 кг", 1, 2, 102, 842),
    ("Корм PRO PLAN для взрослых кошек с чувствительным пищеварением, 3 кг", 1, 2, 567, 282),
    ("Корм Royal Canin для кастрированных кошек и котов: 1-7 лет, 10 кг", 1, 1, 132, 423),
    ("Корм Royal Canin для кастрированных кошек и котов: 1-7 лет, 0,4 кг", 1, 1, 789, 392),
    ("Корм Monge беззерновой для взрослых кошек, с лососем и горохом, 1,5 кг", 1, 7, 92, 883),
    ("Корм Pronature Holistic для взрослых собак: Индейка с клюквой, 2,72 кг", 3, 8, 14, 094),
    ("Monge беззерновые консервы для собак всех пород: индейка с тыквой и кабачками, 0,4 кг", 4, 8, 0, 230),
    ("Monge беззерновые консервы для собак всех пород: ягненок с тыквой и кабачками, 0,4 кг", 4, 8, 3, 230),
    ("Monge консервы для собак: мясной рулет с телятиной, 0,4 кг", 4, 8, 17, 222),
    ("Triol интерактивная игрушка для кошек на батарейках Бабочка", 5, 13, 26, 472),
    ("Развивающий игровой комплекс Рэндал с ковровой когтеточкой", 5, 13, 22, 464),
    ("MR.Crisper корм для дегу, 0,4 кг", 7, 11, 455, 166),
    ("MR.Crisper корм для шиншилл, 0,4 кг", 7, 11, 327, 169),
    ("Royal Canin кусочки в желе для котят: 4-12 месяцев", 2, 2, 1134, 65),
    ("Royal Canin кусочки в соуче для котят: 4-12 месяцев", 2, 2, 1236, 65);
    
    
-- Селекты с джойнами и группировками

-- Выбор заказов с названиями товаров
SELECT items_in_order.*, items.name from items_in_order JOIN items on items.id = items_in_order.item_id;

-- Подсчет количества продаж для каждого продавца с сортировкой по количеству
select purchases.seller_id, name, count(*) as amount_of_sales from purchases join sellers on purchases.seller_id = sellers.seller_id
GROUP BY seller_id
order by amount_of_sales desc;

-- Товары + бренды + категории (джойн 3 таблиц)
SELECT items.id, items.name, amount, price, brands.name as "Brand", country, categories.name as "Category" FROM items 
	JOIN categories 
		on items.category_id = categories.category_id
	join brands 
		on items.brand_id = brands.brand_id;
    
    
-- Представления    
CREATE OR REPLACE VIEW full_items (items_id, items_name, amount, price, brands_name, country, categories_name)
AS SELECT items.id, items.name, amount, price, brands.name as "Brand", country, categories.name as "Category" FROM items 
	JOIN categories 
		on items.category_id = categories.category_id
	join brands 
		on items.brand_id = brands.brand_id
order by price desc limit 5;
        
select * FROM full_items;
show tables;

-- Вертикальное представление всех товаров без цен
CREATE OR REPLACE VIEW full_items_without_price (items_id, items_name, amount, brands_name, country, categories_name)
AS SELECT items.id, items.name, amount, brands.name as "Brand", country, categories.name as "Category" FROM items 
	JOIN categories 
		on items.category_id = categories.category_id
	join brands 
		on items.brand_id = brands.brand_id
WITH CHECK OPTION;

select * FROM full_items_without_price;

-- Представление таблицы clients и его update
CREATE OR REPLACE ALGORITHM = MERGE VIEW clients_view as SELECT * FROM clients
WITH CHECK OPTION;

UPDATE clients_view 
set bonus_card = 578311 WHERE client_id = 5;

SELECT * from clients_view;

-- Триггер: когда в таблице с заказами (orders) появляется новый заказ срабатывает триггер и обновляет сумму бонусных баллов в таблице клиентов (clients)
DROP TRIGGER IF EXISTS bonus_add;

delimiter //

create trigger bonus_add before insert on orders
for each row
BEGIN
	UPDATE clients
    set clients.total_amount = clients.total_amount + new.amount_of_bonuses
    where clients.client_id = new.client_id;
end//

delimiter ;

INSERT INTO 
	orders (client_id, payment_method, amount_of_bonuses, method_of_receiving) 
VALUE 
	(8, "Карта", 100, "Самовывоз");