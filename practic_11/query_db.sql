use logistic_company;

-- выводит заказы первого менеджер с описанием заказа, именем клиента и статусом с сортировкой по цене 
SELECT managers.id ,CONCAT(managers.first_name, ' ', managers.second_name) as 'manager_name',
CONCAT(customers.first_name, ' ', customers.second_name) as 'customer name',
orders.decrition as 'order_desc',
orders.price,
status.description as 'status_desc'
FROM managers
Join order_to_manager on managers.id  = order_to_manager.manager_id
JOIN orders on order_to_manager.order_id = orders.id
JOIN customers on orders.customer_id = customers.id
JOIN status_to_order on orders.id = status_to_order.order_id
JOIN status on status_to_order.status_id  = status.id
WHERE managers.id = 1
ORDER by orders.price DESC;

-- Менеджеры с количеством заказов 
SELECT DISTINCT(CONCAT(managers.first_name, ' ', managers.second_name)) as mn,
count(orders.id)
from managers
JOIN order_to_manager on order_to_manager.manager_id = managers.id
join orders on orders.id = order_to_manager.order_id
GROUP by managers.id;


-- Менежер с минимальным числом закакзов
	
SELECT DISTINCT(CONCAT(managers.first_name, ' ', managers.second_name)) as mn,
count(orders.id)
from managers
JOIN order_to_manager on order_to_manager.manager_id = managers.id
join orders on orders.id = order_to_manager.order_id
GROUP by managers.id
order by 2
limit 1;

-- выводит на экран менеджеров по компаниям
SELECT company.title as 'company title',
count(office.title),
count(department.title),
COUNT(managers.id)
FROM company
join office on office.company_id = company.id
RIGHT join department on department.office_id = office.id
left outer join managers on managers.department_id = department.id
GROUP by company.title;



-- водители, менеджеры и заказы со статусом

SELECT CONCAT(drivers.first_name, ' ', drivers.second_name) as 'Driver name',
		 CONCAT(managers.first_name, ' ', managers.second_name) as 'Manager name', 
		 orders.decrition as 'order description',
		 CONCAT(customers.first_name, ' ', customers.second_name) as 'customer name'
FROM drivers
join drivers_to_manager on drivers_to_manager.driver_id = drivers.id
join managers on drivers_to_manager.manager_id = managers.id
Join order_to_manager on managers.id  = order_to_manager.manager_id
JOIN orders on order_to_manager.order_id = orders.id
JOIN customers on orders.customer_id = customers.id;



-- Количество машин по депо 

SELECT count(cars.id) as 'Число машин',
depo.city
FROM cars
left join depo on cars.depo_id = depo.id
GROUP by depo.id;


-- Машины на заказе

SELECT cars.brand as 'car brand' ,
CONCAT(drivers.first_name , ' ', drivers.second_name) as 'Driver name',
status.id
FROM cars
join drivers_to_car on drivers_to_car.car_id = cars.id
join drivers on drivers.id = drivers_to_car.driver_id
join drivers_to_manager on drivers_to_manager.driver_id = drivers.id
join managers on managers.id = drivers_to_manager.manager_id
Join order_to_manager on managers.id  = order_to_manager.manager_id
RIGHT JOIN orders on order_to_manager.order_id = orders.id
JOIN status_to_order on orders.id = status_to_order.order_id
JOIN status on status_to_order.status_id  = status.id;
 



-- представления 

CREATE VIEW v1000 AS 
SELECT cars.brand
FROM cars
join drivers_to_car on drivers_to_car.car_id = cars.id
join drivers on drivers.id = drivers_to_car.driver_id
join drivers_to_manager on drivers_to_manager.driver_id = drivers.id
join managers on managers.id = drivers_to_manager.manager_id
Join order_to_manager on managers.id  = order_to_manager.manager_id
RIGHT JOIN orders on order_to_manager.order_id = orders.id
WHERE  orders.price > 1000;
 



-- Представление Водители в Пути

CREATE view driver_status AS
SELECT CONCAT(drivers.first_name, ' ', drivers.second_name) as 'Driver Name'
FROM drivers
join drivers_to_manager on drivers_to_manager.driver_id = drivers.id
join managers on managers.id = drivers_to_manager.manager_id
Join order_to_manager on managers.id  = order_to_manager.manager_id
RIGHT JOIN orders on order_to_manager.order_id = orders.id
JOIN status_to_order on orders.id = status_to_order.order_id
JOIN status on status_to_order.status_id  = status.id
WHERE status.id = 1;
 





