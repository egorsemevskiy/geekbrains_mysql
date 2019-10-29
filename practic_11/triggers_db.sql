use logistic_company;

delimiter //

drop trigger if exists driver_to_order//
create trigger driver_to_order 
after insert on orders
	for each row begin
		
			SELECT DISTINCT(CONCAT(managers.first_name, ' ', managers.second_name)) as mn,
				count(orders.id)
			from managers
			JOIN order_to_manager on order_to_manager.manager_id = managers.id
			join orders on orders.id = order_to_manager.order_id
			GROUP by managers.id
			order by 2
			limit 1;

		 
		
		set tmp_name=new.name;
		set tmp_id=new.id;
		insert into logs(created_at, table_name, log_id, log_name) values (now(), 'catalogs', tmp_id, tmp_name);
	end//
	
	
	
