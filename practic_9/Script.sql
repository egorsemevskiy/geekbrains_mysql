##Практическое задание по теме “Транзакции, переменные, представления”

В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
Используйте транзакции.

use shop;

start transaction;
insert ignore into sample.users(id, name, birthday_at, created_at, updated_at) 
	select id, name, birthday_at, created_at, updated_at
		from shop.users where id = 1;
commit;

Создайте представление, которое выводит название name товарной позиции 
из таблицы products и соответствующее название каталога name из 
таблицы catalogs.

create or replace view items as select products.name np, catalogs.name  from products, catalogs where products.catalog_id = catalogs.id;
select * from items;

Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать 
фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

## Практическое задание по теме “Хранимые процедуры и функции, триггеры"

use shop;

drop function if exists hello;

delimiter //
create function hello (value time)
	returns varchar(255) deterministic
begin
	declare greeting varchar(255);

	if (time(value) between '00:00:00' and '06:00:00') then 
		set greeting = 'Доброй ночи';
	elseif (time(value) between '06:00:00' and '12:00:00') then
		set greeting = 'Доброе утро';
	elseif (time(value) between '12:00:00' and '18:00:00') then
		set greeting = 'Добрый день';
	else 
		set greeting = 'Добрый вечер';
	end if;

  	return greeting;
end//

select hello(time(now())) as 'Приветствие'//

В таблице products есть два текстовых поля: name с названием товара и 
description с его описанием. Допустимо присутствие обоих полей или 
одно из них. Ситуация, когда оба поля принимают неопределенное 
значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы 
одно из этих полей или оба поля были заполнены. При попытке присвоить 
полям NULL-значение необходимо отменить операцию.



drop trigger if exists check_products_insert//
create trigger check_products_insert before insert on products
for each row
begin
	if (new.name is null) and (new.description is null) then 
	set new.name = 'default_name', new.description = 'default_text';
	end if;
end//

drop trigger if exists check_products_update//
create trigger check_products_update before update on products
for each row
begin
	if (new.name is null) and (new.description is null) then 
	signal sqlstate '45000' set message_text = 'update canceled'; 
	end if;
end//

show triggers// - 


##

