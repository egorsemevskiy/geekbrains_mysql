 use vk;
 
 
ALTER TABLE users
ADD COLUMN updated_at DATETIME AFTER phone;

ALTER TABLE users
ADD COLUMN  created_at DATETIME AFTER phone;



UPDATE users SET updated_at =  now();

UPDATE users SET created_at =  now();