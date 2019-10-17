use vk;

-- Пункт 1  
-- Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
-- пусть у нас задан id = 1
 
update friend_requests set status = 'approved' where from_user_id = 1 and to_user_id = 4;
insert into messages values 
('108','1','4','test3',now()), 
('109','4','1','test4',now()),
('110','4','1','test5',now());

select 
	u.first_name as 'Имя',
	u.last_name as 'Фамилия',
	u.email as 'Адрес почты',
	u.phone as 'Телефон',
	msg.quantuty_of_messages as 'Количество сообщений'	
	from users as u join
		(select count(*) as quantuty_of_messages, users as users_id from ( 
				select id, to_user_id as users from messages where from_user_id = 1 and to_user_id in (  
				  	select from_user_id from friend_requests where (to_user_id = 1) and status='approved' 
				  	union
				  	select to_user_id from friend_requests where (from_user_id = 1) and status='approved'  
				)
				union
				select id, from_user_id from messages where to_user_id = 1 and from_user_id in (  
					select from_user_id from friend_requests where (to_user_id = 1) and status='approved'  
				  	union
				  	select to_user_id from friend_requests where (from_user_id = 1) and status='approved'  
				)
		) as msg
		group by users_id
		order by quantuty_of_messages desc limit 1) as msg  	 
on u.id = msg.users_id;  


-- Пункт 2  
-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей
-- добавим медиа для молодых пользователей
insert into media values
('101','2','85','A deleniti voluptatum praesentium eveniet.','test1','217626',NULL,now(),now()),
('102','2','85','A deleniti voluptatum praesentium eveniet.','test2','217626',NULL,now(),now()),
('103','2','85','A deleniti voluptatum praesentium eveniet.','test3','217626',NULL,now(),now()),
('104','2','78','A deleniti voluptatum praesentium eveniet.','test4','217626',NULL,now(),now());
 
INSERT INTO `likes` VALUES 
('101','1','101',now()),
('102','2','102',now()),
('103','1','102',now()),
('104','2','103',now()),
('105','1','104',now()),
('106','2','104',now());

select count(*) from likes as l, (	 
	select m.id from media as m,	 
		(select id from users order by (		 
			datediff(curdate(), user_birthday))
		limit 10) as yo   
	where yo.id = m.user_id) as m
where l.media_id = m.id;

-- Пункт 3 
-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
-- добавим колонку "пол" в таблицу users и заполним ее
alter table users add column gender enum('male', 'female', 'it') null;
update users set gender = case round(rand()*1.55)
	when 0 then 'female'
	when 1 then 'male'
	when 2 then 'it'
end;

 
select u.gender as 'Пол', count(*) as 'Лайки' from users as u join (
	select user_id as idn, count(*) as 'Лайки' from likes group by user_id) as l
where u.id = l.idn
group by u.gender;


-- Пункт 4 
-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
-- сортируем пользователей по времени последней активности
-- у нас нет поля с последней активностью (а можно бы его завести и обновлять), поэтому смотрим активности по таблицам:
-- users(updated_at), friend_requests (requested_at, reacted_at), likes, media(updated_at), 
-- messages, photoalbums, photo, profiles, publications(updated_at)

 
update users set created_at = '2008-10-01 10:35:31', updated_at = '2013-10-01 10:35:31' where users.id < 100 and users.id > 95;

 
drop table if exists oldest;
create table oldest(
	user_id bigint unsigned not null,
	last_activity_on datetime default null,  
	
	foreign key(user_id) references users(id)
);
insert into oldest select id, updated_at from users order by updated_at limit 10;
 
insert into oldest select from_user_id, requasted_at from friend_requests order by requasted_at limit 10;
insert into oldest select to_user_id, reacted_at from friend_requests order by reacted_at limit 10;
insert into oldest select user_id, created_at from likes order by created_at limit 10;
insert into oldest select user_id, updated_at from media order by updated_at limit 10;
insert into oldest select user_id, created_at from media order by created_at limit 10;
insert into oldest select from_user_id, created_at from messages order by created_at limit 10;
insert into oldest select user_id, created_at from photoalbums order by created_at limit 10;
insert into oldest select users_id, created_at from profiles order by created_at limit 10;
insert into oldest select from_user_id, updated_at from publications order by updated_at limit 10;
 
select user_id, last_activity_on from oldest group by user_id order by last_activity_on, user_id limit 10;

 
drop table if exists oldest;
 
