use vk;

DROP TABLE IF EXISTS vk.photos;
CREATE TABLE IF NOT EXISTS  photos 
(
	id INT PRIMARY key AUTO_INCREMENT,
	user_id INT not null,
	photo_album_id int not null
);

DROP TABLE IF EXISTS vk.photo_albums;
CREATE TABLE IF NOT EXISTS  photo_albums 
(
	id INT PRIMARY key AUTO_INCREMENT,
	user_id INT not null 	
);


INSERT INTO users (id, firstname, lastname, email, phone, is_deleted )
VALUES ('932','Rueben','Neon', null, null, DEFAULT);


 
INSERT INTO  users VALUES
 ('532','Rueben1','Neon', 'u@ree.ri1', '3231231', DEFAULT),
  ('552','Rueben2','Neon', 'u@ree.ri2', '3231232', DEFAULT),
   ('952','Rueben4','Neon', 'u@ree.ri3', '3231233', DEFAULT),
    ('955','Rueben5','Neon', 'u@ree.ri4', '3231234', DEFAULT),
     ('962','Rueben6','Neon', 'u@ree.ri5', '3231235', DEFAULT),
      ('937','Rueben7','Neon', 'u@ree.ri6', '3231236', DEFAULT);
      
     
INSERT into users
SET
	firstname = 'Rubenn',
	lastname = 'Fwfw',
	email = 'ty@ry.e',
	phone = '3424242';

	
INSERT IGNORE INTO `users` (`firstname`,`lastname`, `email`, `phone`)
SELECT  `firstname`,`lastname`, `email`, `phone`  FROM vk.users where id = 30;
	
	
	
	
SELECT 2 * 2;

SELECT DISTINCT firstname, lastname
FROM users;

SELECT * from users limit 5 offset 5;


SELECT * from users where id = 5 or firstname = 'Victoria';

insert into vk.friend_requests (`initiator_user_id`,`target_user_id`, `status`)
VALUES ('52', '31', 'requested');

insert into vk.friend_requests (`initiator_user_id`,`target_user_id`, `status`)
VALUES ('52', '32', 'requested');

insert into vk.friend_requests (`initiator_user_id`,`target_user_id`, `status`)
VALUES ('52', '33', 'requested');

insert into vk.friend_requests (`initiator_user_id`,`target_user_id`, `status`)
VALUES ('52', '34', 'requested');
	
	

update vk.friend_requests set status = 'approved', confirmed_at = now() 
where `initiator_user_id` = 52 and`target_user_id` = 34;

update vk.friend_requests set status = 'declined', confirmed_at = now() 
where `initiator_user_id` = 52 and`target_user_id` = 33;

insert into users (id, firstname, lastname, email, phone) VALUES 
('222', 'Freedick', 'Upton', 'serwer@2343rew.ere','34241414');

DELETE from vk.messages where id = 222;



-- TRUNCATE table messages;












	
	
     
     
     