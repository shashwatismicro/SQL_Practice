use testSchema2;
-- Stored Procedure

-- First lets make two tables
create table salesX (
	order_id integer,
    order_date Date,
    product_code varchar(10),
    quantity_ordered integer(50),
    sale_price integer(45));

insert into salesX (order_id, order_date, product_code, quantity_ordered, sale_price)
values 
(1, '2022-01-10', 'P1', 100, 120000),
(2, '2022-01-20', 'P2', 50, 60000),
(3, '2022-01-29', 'P3', 45, 540000);

create table productsX (
	product_code varchar(20),
    product_name varchar(100),
    price integer,
    quantity_remaining integer,
    quantity_sold integer);

insert into productsX (product_code, product_name, price, quantity_remaining, quantity_sold)
values
('P1', 'I phone 13', 1000, 5, 195);

select * from productsX;
select * from salesX;

-- Now lets make the procedure
DELIMITER $$
drop procedure if exists pr_buy_products;
create procedure pr_buy_products()
begin
	declare v_product_code varchar(20);
    declare v_price float;
    
    select product_code, price
    into v_product_code, v_price
    from productsX
    where product_name = 'I phone 13';
    
    insert into salesX (order_date, product_code, quantity_ordered, sale_price)
    values
    (current_date, v_product_code, 1, (v_price*1));
    
    update productsX
    set quantity_remaining = (quantity_remaining - 1),
    quantity_sold = (quantity_sold + 1)
    where product_code = v_product_code;
    
    select 'Product Sold!';
end $$

-- stored procedure with parameters

create table productsY (
	product_code varchar(20),
    product_name varchar(100),
    price integer,
    quantity_remaining integer,
    quantity_sold integer);

insert into productsY
values
('P1', 'Iphone 13 Pro', 1200, 8, 192),
('P2', 'AirPodsPro', 500, 20, 180),
('P3', 'MacBookPro', 5200, 43, 157),
('P4', 'Ipad Air', 650, 150, 50);
    
create table salesY (
	order_id integer primary key,
    order_date Date,
    product_code varchar(10),
    quantity_ordered integer,
    sale_price integer);
    
insert into salesY
values
(1, '2022-01-10', 'P1', 100, 120000),
(2, '2022-01-20', 'P1', 50, 60000),
(3, '2022-01-25', 'P1', 25, 30000),
(4, '2022-01-30', 'P2', 20, 6000),
(5, '2022-02-10', 'P2', 10, 3000),
(6, '2022-02-15', 'P2', 5, 1500),
(7, '2022-02-20', 'P2', 1, 300),
(8, '2022-02-27', 'P3', 40, 120000),
(9, '2022-03-05', 'P3', 20, 60000),
(10, '2022-03-10', 'P3', 10, 4000),
(11, '2022-03-20', 'P3', 5, 1500),
(12, '2022-03-30', 'P4', 100, 120000),
(13, '2022-04-10', 'P4', 50, 60000),
(14, '2022-04-20', 'P4', 20, 25000),
(15, '2022-04-30', 'P4', 10, 12000),
(16, '2022-05-10', 'P4', 5, 6000);

-- For every product and quantity check: product availability based on quantity; if available then modify database

DELIMITER $$
create procedure p_buy_products(p_product_name varchar(50), p_quantity integer)
begin
	declare v_product_code   varchar(20);
    declare v_price          float;
    declare v_count	         int;
    declare v_order_id	     int;
    
    select count(1)
    into v_count
    from productsY
    where product_name = p_product_name
    and quantity_remaining >= p_quantity;
    
    select order_id + 1
    into v_order_id
    from salesY
    order by order_id desc limit 1;
    
    if v_count > 0 then
		select product_code, price
		into v_product_code, v_price
		from productsY
		where product_name = p_product_name;
		
		insert into salesY (order_id, order_date, product_code, quantity_ordered, sale_price)
		values
		(v_order_id, current_date, v_product_code, p_quantity, (v_price * p_quantity));
		
		update productsY
		set quantity_remaining = (quantity_remaining - p_quantity),
		quantity_sold = (quantity_sold + p_quantity)
		where product_code = v_product_code;
    
		select 'Product Sold!';
        
	else
		select 'Insufficient Quantity';
    end if;
end $$

call p_buy_products('AirPodsPro', 5);

select * from productY;
select * from salesY;