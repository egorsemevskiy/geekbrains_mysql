use logistic_company;



drop TABLE if exists company;
CREATE TABLE company (
	id serial PRIMARY KEY,
	title varchar(200) UNIQUE not NULL,
	cheif varchar(200) not NULL,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

);


drop TABLE if EXISTS office;
CREATE TABLE office (
	id serial PRIMARY KEY,
	city VARCHAR(100),
	district varchar(100),
	title varchar(100) UNIQUE,
	company_id  BIGINT UNSIGNED NOT NULL,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (company_id) REFERENCES company(id)

);



drop TABLE if EXISTS department;
CREATE TABLE department (
	id serial PRIMARY KEY,
	office_id  BIGINT UNSIGNED NOT NULL,
	title varchar(100) UNIQUE,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (office_id) REFERENCES office(id)

);

DROP TABLE if EXISTS managers;
CREATE TABLE managers (
	id serial PRIMARY KEY,
	first_name varchar(100) not null,
	second_name varchar(100) not null,
	birthday date,
	gender CHAR(1),
	start_work DATETIME DEFAULT Now(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	is_fired bit(1) DEFAULT 0,
	salary int(100),
	shift int(3) DEFAULT 1,
	department_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (department_id) REFERENCES department(id)
);

DROP TABLE if EXISTS customers;
create table customers (
	id serial PRIMARY key,
	first_name varchar(100) not null,
	second_name varchar(100) not null,
	birthday date
);

drop TABLE if EXISTS orders;
CREATE TABLE orders (
	id serial PRIMARY key,
	decrition varchar(255) not null,
	price int(100) not null,
	from_customer_id BIGINT UNSIGNED NOT NULL,
	point_a varchar(255) not null,
	point_b varchar(255) not null,
	FOREIGN KEY (from_customer_id) REFERENCES customers(id)
);



DROP TABLE IF EXISTS order_to_manager;
CREATE TABLE order_to_manager (
	order_id BIGINT UNSIGNED NOT NULL,
	manager_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY(order_id, manager_id),
	FOREIGN KEY (order_id) REFERENCES orders(id),
	FOREIGN KEY (manager_id) REFERENCES managers(id)
	
);


Drop table if EXISTS drivers;
CREATE table drivers (
	id serial PRIMARY KEY,
	first_name varchar(100) not null,
	second_name varchar(100) not null,
	start_work datetime DEFAULT now()
);

Drop table if EXISTS drivers_to_manager;
CREATE table drivers_to_manager (
	driver_id BIGINT UNSIGNED NOT NULL,
	manager_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY(driver_id, manager_id),
	FOREIGN KEY (driver_id) REFERENCES drivers(id),
	FOREIGN KEY (manager_id) REFERENCES managers(id)
);


Drop table if EXISTS depo;
CREATE table depo (
	id serial PRIMARY KEY,
	city varchar(100) not null
); 


Drop table if EXISTS cars;
CREATE table cars (
	id serial PRIMARY KEY,
	brand varchar(100) not null,
	start_work datetime DEFAULT now(),
	depo_id bigint not null
); 



Drop table if EXISTS drivers_to_car;
CREATE table drivers_to_car (
	driver_id BIGINT UNSIGNED NOT NULL,
	car_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY(driver_id, car_id ),
	FOREIGN KEY (driver_id) REFERENCES drivers(id),
	FOREIGN KEY (car_id) REFERENCES cars(id)
);



Drop table if EXISTS status;
CREATE table status (
	id serial PRIMARY KEY,
	description varchar(255) not null,
	priority int(10) not null
);


Drop table if EXISTS status_to_order;
CREATE table status_to_order (
	order_id BIGINT UNSIGNED NOT NULL,
	status_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY(order_id, status_id),
	FOREIGN KEY (order_id) REFERENCES orders(id),
	FOREIGN KEY (status_id) REFERENCES status(id)
);



 












