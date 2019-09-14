CREATE DATABASE example CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id serial PRIMARY KEY,
	name varchar(255)
);