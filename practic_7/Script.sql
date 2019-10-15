use shop;
 
-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
SELECT * FROM users as u JOIN (
	SELECT distinct user_id FROM orders) as o
where u.id = o.user_id;
 
-- Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT p.name, c.name FROM products as p JOIN catalogs as c where p.catalog_id = c.id;
 
-- Пусть имеется таблица рейсов flights (id, FROM, to) и таблица городов cities (label, name). Поля FROM, to и label 
-- содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
 
DROP database if EXISTS flights;
CREATE database flights;


use flights;



DROP TABLE if EXISTS cities;
CREATE TABLE cities (
	  label varchar(255),
	  name varchar(255)
);

DROP TABLE if EXISTS eng_flights;
CREATE TABLE eng_flights (
	  id serial primary key,
	  FROM_ varchar(255),
	  to_ varchar(255)
);

 
INSERT INTO cities VALUES 
	('moscow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('novgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск');

INSERT INTO eng_flights VALUES 
	('1', 'moscow', 'omsk'),
	('2', 'novgorod', 'kazan'),
	('3', 'irkutsk', 'moscow'),
	('4', 'omsk', 'irkutsk'),
	('5', 'moscow', 'kazan');

 


SELECT en.id, cf.name, ct.name 
FROM eng_flights as en 
JOIN cities as cf 
JOIN cities as ct
on en.FROM_ = cf.label 
and en.to_ = ct.label
order by en.id;
 
DROP database flights;