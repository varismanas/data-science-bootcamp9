--crear customers lost
CREATE TABLE customers(
  id int primary key,
  name varchar(255),
  DOB date,
  email varchar(255)
);

insert into customers
VALUES
  (1, 'John', '1990-01-01','jh@yahoo.com'),
  (2, 'Jane', '1990-02-01','je@google.com'),
  (3, 'Jack', '1990-02-02','jk@hotmail.com');

.mode box
.print "\n\nCustomers table"
select * from customers;

--create Pizza order
CREATE TABLE Piz_order(
  order_id int primary key,
  customer_id int,
  order_date DATETIME,
  menus_id int,
  quantity int
);

insert into Piz_order
VALUES
  (1, 1, '2023-01-01',1, 2),
  (2, 2, '2023-01-03',3, 1),
  (3, 3, '2023-01-03',4, 3),
  (4, 2, '2023-01-08',5, 1),
  (5, 1, '2023-01-09',2, 3);

.mode box
.print "\n\nPiz_order"
select * from Piz_order;


--create piz menus
CREATE TABLE piz_menus(
  menus_id int primary key,
  menus_name varchar(255),
  price int
);
insert into piz_menus
VALUES 
  (1, 'Peperoni', 100),
  (2, 'italian hate', 149),
  (3, 'Hot Head', 179),
  (4, 'Hawaiian', 150),
  (5, 'Veggie', 120);

.mode box
.print "\n\npiz_menus"
select * from piz_menus;

--JOIN
-- find most order by customer
.print "\n\nMost order by customer"
select 
  id,
  name AS customer_name,
  sum(quantity) AS total_order
from customers
join Piz_order  on customers.id = Piz_order.customer_id
group by 1
order by 3 desc;

--- CREATE VIEWs + Aggregate 
--- For create stat that can auto update
CREATE VIEW customer_stat AS
SELECT
    cus.name,
    sum(quantity) as total_order,
    AVG(quantity) AS avg_per_order 
FROM customers AS cus 
JOIN Piz_order ON cus.id = Piz_order.customer_id
GROUP BY 1
ORDER BY 3 DESC;
.mode box
.print "\n\ncustomer_stat"
SELECT * from customer_stat;

--USE LIKE Operator
--select customer that use hotmail.com
.print "\n\ncustomer that use hotmail.com"
SELECT 
  email,
  name
FROM customers
WHERE email like '%@hotmail%' ;


--WITH + Aggregate 
--FIND Oreder by customer
.print "\n\ntotal_order_per_cus"
WITH cal AS (
Select
  count(distinct customer_id) AS total_cus,
  count(order_id) AS total_order,
  count(order_id)/count(distinct customer_id) AS avg_order_per_cus
FROM piz_order)
  
SELECT
total_cus*total_order AS total_order_per_cus
From cal;


--Use Subquery
--find total revenue

.print "\n\ntotal revenue"
SELECT 
sum(price * quantity) AS total_revenue
from (SELECT 
      price,
      quantity,
      price * quantity AS total_price
      from piz_order
      inner join piz_menus on piz_order.menus_id = piz_menus.menus_id);

--find pizza that Jane eat
.print "\n\npizza that Jane eat"
SELECT
  name,
  menus_name,
  quantity,
  order_date
from piz_menus as pizmenus
join piz_order on piz_order.menus_id = pizmenus.menus_id
join customers on piz_order.customer_id = customers.id
where customer_id = 2;





