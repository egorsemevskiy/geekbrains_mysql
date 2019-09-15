-- Домашняя работа, практика №3

drop DATABASe if EXISTS exam_3;
CREATE DATABASE exam_3;
use  exam_3;

/* задача один
* Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
*/

drop table if EXISTS users;
CREATE TABLE users (
	id serial PRIMARY key,
	created_at datetime DEFAULT now(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

insert into users (created_at, updated_at) values (CURDATE(),NOW());



/* задача один
* Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы 
* типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
* Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
*/

drop table if EXISTS quest;
CREATE TABLE quest (
	id serial PRIMARY key,
	created_at varchar(255),
	updated_at varchar(255)
);


INSERT INTO quest (created_at, updated_at) values ("20.10.2017 8:10", "24.12.2019 8:10");

ALTER TABLE quest ADD created_at_new datetime;
UPDATE quest set created_at_new = 	STR_TO_DATE(created_at, '%d.%m.%Y %H:%i' );
ALTER TABLE quest DROP created_at;
ALTER TABLE quest CHANGE COLUMN created_at_new created_at datetime;


/*
 * В таблице складских запасов storehouses_products в поле 
 * value могут встречаться самые разные цифры: 0, если товар закончился и выше 
 * нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
 * чтобы они выводились в порядке увеличения значения value. Однако, нулевые
 *  запасы должны выводиться в конце, после всех записей.
 */

drop table if EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id serial PRIMARY key,
	value int(11) UNSIGNED
);



insert   storehouses_products (value) VALUES (2),
 											(3),
 											(0),
 											(5),
 											(8),
 											(9),
 											(53),
 											(53),
 											(74),
 											(83),
 											(15),
 											(26),
 											(26),
 											(0);

	

-- Не понял, почему этот селект выполняет условие задачи, но работает. 
SELECT value from storehouses_products  ORDER BY value=0  , value; 














