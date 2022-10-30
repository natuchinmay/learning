-- 1 CREATE book_dtl table
CREATE DATABASE library;
USE library;
CREATE TABLE book_dtl (
book_id			INT					NOT NULL,
book_name		VARCHAR(20)			NOT NULL,
author_name		VARCHAR(20)			NOT NULL,
num_pages		INT					NOT NULL,
price			INT					NOT NULL,
PRIMARY KEY (book_id)
);

-- 2. load data in book_dtl
INSERT INTO book_dtl VALUES
("102","Dasbodh","Ramdas Swami","504","2000"),
("103","Agnipankh","APJ Abdul Kalam","244","200"),
("104","Let Us C","Yashvant Kanitkar","250","300"),
("105","Pointers in C","Yashvant Kanitkar","340","300"),
("106","Unix SHell Scripting","Tashvant Kanitkar","250","200"),
("107","Python","Guido Van Rossum","360","1000"),
("108","Python Pandas","Guido Van Rossum","410","1230"),
("109","Java","Oracle","324","230"),
("110","Power BI","Microsoft Ltd","510","650"),
("111","Mrutyunjay","Shivaji Sawant","388","600"),
("112","Raja Shivchatrapati","Babasaheb Purandare","455","2000");

-- 3. store_dtl table
USE retail;
DROP TABLE store_dtl;
CREATE TABLE store_dtl (
store_id			INT					NOT NULL,
store_city			VARCHAR(20)			NOT NULL,
store_state			VARCHAR(20)			NOT NULL,
contact_num			VARCHAR(20)				NOT NULL,
PRIMARY KEY (store_id)
);

-- 4. store_dtl load data
INSERT INTO store_dtl VALUES
("1", "Satara", "Maharashtra", "02162-234567"),
("2", "Pune", "Maharashtra", "020-23456789"),
("3", "Aurangabad", "Maharashtra", "0240-2345678");

-- 5. family detail table
CREATE DATABASE family;
USE family;
CREATE TABLE family_dtl (
first_name			VARCHAR(20)			NOT NULL,
middle_name			VARCHAR(20)			NOT NULL,
last_name			VARCHAR(20)				NOT NULL,
age					INT					NOT NULL,
relation_with_you	VARCHAR(20)			NOT NULL,
PRIMARY KEY (first_name,relation_with_you)
);

-- 6. add city column
USE family;
ALTER TABLE family_dtl ADD COLUMN city VARCHAR(20);
SELECT * FROM family_dtl;

-- 7. adding column DOB
ALTER TABLE family_dtl ADD COLUMN dob DATE AFTER last_name;

-- 8. delete age column
ALTER TABLE family_dtl DROP COLUMN age;

-- 9. delete family table
DROP TABLE family_dtl;

-- 10. book price column rename
USE library;
ALTER TABLE book_dtl RENAME COLUMN price TO book_price;
SELECT * FROM book_dtl;

-- 11 display emp id and first name of amployees
USE emp;
SELECT emp_no AS emp_id, first_name
FROM employees;

-- 12 to show all products all columns
USE retail;
SELECT * FROM product;

-- 13 to show details for any two categories
USE retail;
SELECT product_id, description, category
FROM product
WHERE category ="Baked goods" OR category = "Dairy";

-- 14 inserting three products with description empty
USE retail;
DESCRIBE product; 
USE retail;
SELECT product_id, description, category FROM product WHERE category = "Baked Goods" OR category = "Dairy";

-- 15 generate report where empty description shows standard product
USE retail;
-- SET SQL_SAFE_UPDATES = 0; -- to allow update
-- UPDATE product
-- SET description = "Standard Product"
-- WHERE description = "";
SELECT product_id, description
FROM product;


-- 16 	Generate report showing total number of employees.
use emp;
select count(emp_no) as total_employee
from employees;

-- 17 	Generate report showing total number of transactions at store 2.
use retail;
select store_id, count(tran_id) as total_tran_store2
from tran_hdr
where store_id = "2";

-- 18 	Generate report showing average price for baked goods category.
use retail;
select * from product;
select category, avg(price) as avg_price_baked_goods
from product
where category = "baked goods";

-- 19 	Generate report showing number of employees born in year 1960.
use emp;
select * from employees;
select first_name, birth_date 
from employees
where year(birth_date) = 1960;

-- 20 	Generate report showing min price for beverages category.
use retail;
select* from product;
select category, min(price)
from product
where category = "beverages";

-- 21 	Generate report showing max price for frozen category.
use retail;
select* from product;
select category, max(price)
from product
where category = "frozen";

-- 22 	Generate report showing total amount of sales for transaction date 2019-08-12.
 use retail;
select* from tran_dtl;
select tran_dt, sum(amt) as total_amt
from tran_dtl
where tran_dt ="2019-08-12";

-- 23 Generate report showing monthly sale for each month.
use retail;
select * from tran_dtl;
select month(tran_dt) as month, sum(amt) as monthly_sale
from tran_dtl
group by month(tran_dt);

-- 24 Generate report showing employees who have worked in more than one department.
use emp;
select * from dept_emp;
select emp_no, count(dept_no) as no_of_dept
from dept_emp
group by emp_no
having count(dept_no) >1;

-- 25 Generate report showing total number of managers for each department.
use emp;
select * from dept_manager;
select count(emp_no) as total_manager, dept_no
from dept_manager
group by dept_no;

-- 26 Generate report showing total salary withdrawn from company for each employee.
use emp;
select * from salaries;
select emp_no, sum(salary) as total_salary
from salaries
group by emp_no;

-- 27 Generate report showing only those employees from above report who have withdrawn total 
-- salary in between 400000 to 500000and arrange them in descending order by salary withdrawn.
use emp;
select * from salaries;
select emp_no, sum(salary)
from salaries
group by emp_no
having sum(salary) > ("400000") & sum(salary) < ("500000")
order by sum(salary) desc;

-- 28 Genetaye report showing total number of transactions per member per month.
use retail;
select * from tran_hdr;
select member_id, concat(month(tran_dt)) as month, count(tran_id) as total_tran
from tran_hdr
group by member_id, month(tran_dt)
order by member_id, month(tran_dt);

-- 29 Generate report showing total number of transaction per month per store in ascending order.
use retail;
select * from tran_hdr;
select store_id, concat(month(tran_dt)) as month, count(tran_id) as total_tran
from tran_hdr
group by store_id, month(tran_dt)
order by store_id, month(tran_dt) asc;

-- 30 Generate report showing number of members registered per month per store.
use retail;
select * from tran_hdr;
select concat(member_id) as no_of_member, concat(month(tran_dt)) as month, store_id
from tran_hdr
group by member_id, store_id;

-- 31 Generate report showing category wise number of products having price less than 1.
use retail;
select * from product;
select category, price, count(product_id) 
from product
where price < 1
group by category;

-- 32 Generate report showing total number of transactions per member per store.
use retail;
select * from tran_hdr;
select  member_id, count(tran_id) as total_tran, store_id
from tran_hdr
group by member_id, store_id
order by member_id, store_id;

-- 1. Generate report that shows number of transactions per member per store. (Show member name and store city).
USE retail;
SELECT m.first_name, s.store_city, COUNT(th.tran_id) AS no_transactions
FROM tran_hdr th
JOIN member m
ON th.member_id = m.member_id
JOIN store_dtl s
ON th.store_id = s.store_id
GROUP BY s.store_id, m.member_id
ORDER BY m.member_id;

-- 2. Generate a report that shows total product sale by month. show product_description, month and sale
USE retail;
SELECT p.description, MONTHNAME(td.tran_dt) AS MONTH, SUM(td.amt) AS total_sale
FROM tran_dtl td
JOIN product p
ON td.product_id = p.product_id
GROUP BY p.product_id, MONTH(td.tran_dt)
ORDER BY p.product_id;

-- 3. Generate a report that shows total sale by member, product and month. (show member name, product description, month, total_sale on the report.)
USE retail;
SELECT m.first_name, p.description, MONTHNAME(td.tran_dt) AS month, SUM(td.amt) AS total_sale
FROM tran_dtl td
JOIN tran_hdr th
ON td.tran_id = th.tran_id
JOIN member m
ON th.member_id = m.member_id
JOIN product p
ON td.product_id = p.product_id
GROUP BY th.member_id, MONTH(td.tran_dt), p.description
ORDER BY th.member_id, MONTH(td.tran_dt);

-- 4. Generate a report that shows employee number, first name, title, department name.
USE emp;
SELECT de.emp_no, e.first_name, t.title, d.dept_name
FROM dept_emp de
JOIN employees e
ON de.emp_no = e.emp_no
JOIN titles t
ON de.emp_no = t.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
ORDER BY de.emp_no;

-- 5. Generate report that shows title wise number of employees in each department. (show department number and department name)
USE emp;
SELECT de.dept_no, d.dept_name, t.title, COUNT(t.title) AS no_employees
FROM dept_emp de
JOIN departments d
ON de.dept_no = d.dept_no
JOIN titles t
ON de.emp_no = t.emp_no
GROUP BY de.dept_no, t.title
ORDER BY de.dept_no;



------------------ # CASE WHEN ASSIGNMENT- 2 # --------------------

-- 1.
-- generate a report showing product table with one added column prod_cat that classifies product with average price of all products
-- (greater, smaller, avg_price)

select product_id, description, price, category, max_qty,
case when price > 2.921559611 then "greater"
     when price <= 2.921559611 then "smaller"
     end as prod_cat
from product;

-- 2.
-- generate a report showing classification of member based on member and products(in quantity) purchased by him 

select * from member;
select * from tran_hdr;
select * from tran_dtl;

select th.member_id, sum(td.qty) as total_qty_prod,
case when sum(td.qty) > 700 then "platinum"
     when sum(td.qty) <= 700 and sum(td.qty) > 600 then "diamond"
     when sum(td.qty) <= 600 then "gold"
     end as classification
from tran_dtl td
join tran_hdr th
on td.tran_id = th.tran_id
group by th.member_id;


-- 3.
-- generate a report showing tran_dtl table with one additional column quarter  showing quarter of tran_dt

select tran_id, product_id, qty, tran_dt, 
case when month(tran_dt) in ("1","2","3") then "Q1"
     when month (tran_dt) in ("4","5","6") then "Q2"
	 when month(tran_dt) in ("7","8","9") then "Q3"
     when month(tran_dt) in ("10","11","12") then "Q4"
     end as quarter
from tran_dtl;

-- 4.
-- gemerate a report showing no. of transactions per quarter
-- (qtr_name, num_tran)

select distinct(count(tran_id)) as num_tran, 
case when month(tran_dt) in ("1","2","3") then "Q1"
     when month (tran_dt) in ("4","5","6") then "Q2"
	 when month(tran_dt) in ("7","8","9") then "Q3"
     when month(tran_dt) in ("10","11","12") then "Q4"
     end as quarter
from tran_dtl
group by quarter;

-- 5.
-- generate a report showing no of tran per store per quarter
-- (store_id, store_city, num_tran) 

select count(td.tran_id) as num_tran, sd.store_id, sd.store_city,
case when month(td.tran_dt) in ("1","2","3") then "Q1"
     when month (td.tran_dt) in ("4","5","6") then "Q2"
	 when month(td.tran_dt) in ("7","8","9") then "Q3"
     when month(td.tran_dt) in ("10","11","12") then "Q4"
     end as quarter
from tran_dtl td
join tran_hdr th
on td.tran_id = th.tran_id
join store_id sd
on th.store_id = sd.store_id
group by sd.store_id, quarter;

-- 6.
-- generate a report showing no of tran per member per quarter
-- ( member_id, quarter, num_tran)

select count(td.tran_id) as num_tran, th.member_id, 
case when month(td.tran_dt) in ("1","2","3") then "Q1"
     when month (td.tran_dt) in ("4","5","6") then "Q2"
	 when month(td.tran_dt) in ("7","8","9") then "Q3"
     when month(td.tran_dt) in ("10","11","12") then "Q4"
     end as quarter
from tran_dtl td
join tran_hdr th
on td.tran_id = th.tran_id
group by th.member_id, quarter;

-- 7.
-- generate a report showing no of tran per store per member per quarter
-- (member_id, store_id, quarter, num_tran)
 
select count(td.tran_id) as num_tran, sd.store_id, sd.store_city,
case when month(td.tran_dt) in ("1","2","3") then "Q1"
     when month (td.tran_dt) in ("4","5","6") then "Q2"
	 when month(td.tran_dt) in ("7","8","9") then "Q3"
     when month(td.tran_dt) in ("10","11","12") then "Q4"
     end as quarter
from tran_dtl td
join tran_hdr th
on td.tran_id = th.tran_id
join store_id sd
on th.store_id = sd.store_id
group by sd.store_id, th.member_id, quarter;

-- 8.
-- generate a report showing total sale for each product for product classification according to total sale
-- (product_id, description, total_sale, classification)

select  sum(td.amt) as total_sale, td.product_id, p.description, 
case when sum(td.amt) > 2500 then "high"
     when sum(td.amt) <= 2500 and sum(td.amt) >1500 then "medium"
     when sum(td.amt) <= 1500 then "low"
     end as classification
from tran_dtl td
join product p
on td.product_id = p.product_id
group by td.product_id;

-- 9.
-- generate a report showing total sale for each product, each quarter
-- (product_id, description, qtr, total_sale)

select  sum(td.amt) as total_sale, td.product_id, p.description, 
case when month(td.tran_dt) in ("1","2","3") then "Q1"
     when month (td.tran_dt) in ("4","5","6") then "Q2"
	 when month(td.tran_dt) in ("7","8","9") then "Q3"
     when month(td.tran_dt) in ("10","11","12") then "Q4"
     end as quarter
from tran_dtl td
join product p
on td.product_id = p.product_id
group by td.product_id, quarter;
 
-- 10. 
-- generate a report showing total sale for eacg category each qtr
-- ( category, qtr, total_sale )

select  sum(td.amt) as total_sale, p.category, 
case when month(td.tran_dt) in ("1","2","3") then "Q1"
     when month(td.tran_dt) in ("4","5","6") then "Q2"
	 when month(td.tran_dt) in ("7","8","9") then "Q3"
     when month(td.tran_dt) in ("10","11","12") then "Q4"
     end as quarter
from tran_dtl td
join product p
on td.product_id = p.product_id
group by p.category, quarter;

-- 1. Generate report showing member_id, first_name for only those members who have at least one transaction with total sale less than 4 dollars.
SELECT m.member_id, m.first_name, B.tran_id, B.amt
FROM member m
JOIN
(SELECT th.tran_id, A.amt, th.member_id
FROM tran_hdr th
JOIN
(SELECT td.tran_id, td.amt 
FROM tran_dtl td 
WHERE amt < "4") A
ON th.tran_id = A.tran_id) B 
ON m.member_id = B.member_id;

-- 2. Generate report showing member table for those employees who have purchased product id 78 in at least one transaction.
SELECT * 
FROM member m
JOIN 
(SELECT th.tran_id, th.member_id
FROM tran_hdr th
JOIN 
(SELECT td.product_id, td.tran_id
FROM tran_dtl td
WHERE td.product_id = "78") A 
ON th.tran_id = A.tran_id) B
ON m.member_id = B.member_id;
  --                                OR
SELECT *
FROM member m
JOIN
            (SELECT th.tran_id, th.member_id
            FROM tran_hdr th
							JOIN
							(SELECT tran_id FROM tran_dtl td
							WHERE product_id=78) op1
			ON th.tran_id=op1.tran_id) op2
ON m.member_id=op2.member_id;

-- 3. Generate report showing tran_hdr table only for those transactions in which at lease one product from baked goods category is purchased.
SELECT * 
FROM tran_hdr th
JOIN
(SELECT td.tran_id, td.product_id, A.category
FROM tran_dtl td
JOIN 
(SELECT p.product_id, p.category
FROM product p
WHERE p.category = "baked goods") A
ON td.product_id = A.product_id) B
ON th.tran_id = B.tran_id
GROUP BY th.tran_id
ORDER BY th.tran_id;
  -- OR
SELECT th.tran_id, th.member_id, tran_dt from tran_hdr th
JOIN
(
SELECT td.tran_id FROM tran_dtl td
JOIN
(SELECT product_id FROM product
WHERE category="Baked goods") op1
ON td.product_id=op1.product_id
) op2
ON th.tran_id=op2.tran_id
GROUP BY th.tran_id
ORDER BY th.tran_id

--  1. Generate report showing member table with additional column country with value as INDIA
SELECT * FROM member;
SELECT *, "INDIA" AS country
FROM member;

-- 2..Generate report showing product table with derived column company with value HALDIRAM..
SELECT * FROM product;
SELECT *, "HALDIRAM" AS company
FROM product;

-- 3..Generate report showing product table with derived coiumn new price which is 1.25 times from original price..
SELECT * FROM product;
SELECT *, (price*1.25) AS new_price
FROM product;

-- 4..Generate report showing product table with derived column discounted price which is 80% of original price..
SELECT * FROM product;
SELECT *, (price*0.8) AS discounted_price 
FROM product; 

/*1. Generate report showing member table with additional column showing season for registration date.
	(Spring - March, Apr, May
	Summer - June, July, Aug
	Autumn - Sept, Oct, Nov
	Winter - Dec, Jan, Feb)..*/
    SELECT *,
    CASE
    WHEN month(reg_date) IN (3,4,5) THEN "spring"
    WHEN month(reg_date) IN (6,7,8) THEN "summer"
    WHEN month(reg_date) IN (9,10,11) THEN "Autumn"
    WHEN month(reg_date) IN (12,1,2) THEN "Winter"
    END
    AS regis_season FROM member;
    
     
   /*  Generate report showing product table with additional column for product classification.
	(Low price => price less than 3
	Medium price => price in between 3 and 6
	High price => price greater than 6)..*/
    SELECT *,
    CASE 
    WHEN price < 3 THEN "Low Price"
    WHEN price between 3 and 6 THEN "Medium price"
    WHEN price > 6 THEN "High Price"
    END AS Price_Range
    FROM product;
    
    
   /* 3. Generate report showing tran_id, total sale amount and classification of total sale
	(Low amount transaction => price less than 33
	Medium amount transaction => price in between 33 and 66
	High amount transaction => price greater than 66)*/
    SELECT *,
    CASE
    WHEN sum(amt) < 33 THEN "Low Amount"
    WHEN sum(amt) between 33 and 66 THEN "Medium Amount"
    WHEN sum(amt) > 66 THEN "High Amount"
    END AS Price_Range
    FROM tran_dtl 
    GROUP BY tran_id;
   
    -- 1.. Generate report showing no. of members registered per store..
USE retail;
SELECT * FROM member_t;
SELECT member_id, reg_store 
FROM member_t
GROUP BY reg_store;

-- 2.. Generate report showing no. of member registered per store per month..
USE retail;
SELECT  member_id, store_id, month(reg_date) AS month
FROM member
GROUP BY store_id, month(reg_date)
ORDER BY store_id, month(reg_date);

-- 3..Generate report showing no. of products per category...
USE retail;
SELECT * FROM product;
SELECT category, count(product_id)
FROM product
GROUP BY category;

-- 4.. Generate report showing no. of transaction per member
USE retail;
SELECT * FROM tran_hdr;
SELECT member_id, count(tran_id) 
FROM tran_hdr
GROUP BY member_id;

-- 5..Generate report showing no. of transaction per store..
USE retail;
SELECT * FROM tran_hdr;
SELECT store_id, count(tran_id)
FROM tran_hdr
GROUP BY store_id;

-- 6.. Generate report showing no. of transaction per member per store..
USE retail;
SELECT * FROM tran_hdr;
SELECT member_id, store_id, count(tran_id)
FROM tran_hdr
GROUP BY member_id, store_id;

-- 7.. Generate report showing no. of transactions per member per month..
USE retail;
SELECT * FROM tran_hdr;
SELECT member_id, month(tran_dt) AS month, count(tran_id)
FROM tran_hdr 
GROUP BY member_id, month(tran_dt);

-- 8.. generate report showing no. of transactions per store per month..
USE retail;
SELECT * FROM tran_hdr;
SELECT store_id, month(tran_dt) AS month, count(tran_id)
FROM tran_hdr
GROUP BY store_id, month(tran_dt);

-- 9.. Generate report showing no. of transctions per member per store per month..
USE retail;
SELECT * FROM tran_hdr;
SELECT member_id, store_id, month(tran_dt) AS month, count(tran_id)
FROM tran_hdr
GROUP BY member_id, store_id, month(tran_dt);

-- 10.. Generate report showing no. of transactions per store in descending order..
USE retail;
SELECT * FROM tran_hdr;
SELECT store_id, count(tran_id) 
FROM tran_hdr
GROUP BY store_id
ORDER BY (store_id) desc;

-- 11.. Generate report showing total number of transaction in which product 17 was purchased..
USE retail;
SELECT * FROM tran_dtl;
SELECT product_id, sum(tran_id)
FROM tran_dtl
GROUP BY product_id
HAVING product_id = "17";

-- 12.. Generate report showing total number transactions per month..
USE retail;
SELECT * FROM tran_dtl;
SELECT month(tran_dt) AS month, sum(tran_id) 
FROM tran_dtl
GROUP BY  month(tran_dt);

 -- 1.. Generate report showing avrage price of all products..
USE retail;
SELECT * FROM product;
SELECT avg(price) AS all_product FROM product;

-- 2.. Generate report showing total number of members..
USE retail;
SELECT * FROM member;
SELECT count(member_id) AS no_of_member FROM member;

-- 3.. Generate report showing total number of employees...
USE emp;
SELECT * FROM employees;
SELECT count(emp_no) AS no_of_employees FROM employees;

-- 4.. Generate report showing total salary withdrawn by all employees..
USE emp;
SELECT * FROM salaries;
SELECT count(emp_no), sum(salary) AS total_salary_withdrawn_by_all_employees FROM salaries;

-- 5.. Generate report showing avarage salary of employee..
USE emp;
SELECT * FROM salaries;
SELECT avg(salary) FROM salaries;

-- 6..Generate report showing maximum salary withdrawn..
USE emp;
SELECT * FROM salaries;
SELECT  max(salary)  FROM salaries;

-- 7..Generate report showing minimum salary withdrawn..
USE emp;
SELECT * FROM salaries;
SELECT min(salary) FROM salaries;  
-- 1.. Generate report showing all details employees table...
USE emp; 
SELECT * FROM employees;

-- 2.. Generate report showing all details of salaries table..
USE emp;
SELECT * FROM salaries;

-- 3.. Generate report showing all details of departments table..
USE emp;
SELECT * FROM departments;

-- 4.. Generate report showing all details of dept_emp table..
USE emp; 
SELECT * FROM dept_emp;

-- 5.. Generate report showing all details of titles table..
USE emp;
SELECT * FROM titles;

-- 6.. Generate report showing member_id, first_name, last_name from member table..
USE retail;
SELECT member_id, first_name, last_name FROM member;

-- 7.. Generate report showing member_id, reg_date & reg_store from member table..
USE retail;
SELECT member_id, reg_date, reg_store FROM member_pref;

-- 8.. Generate report showing product_id, description, price from product table..
USE retail;
SELECT product_id, description, price FROM product;

-- 9.. Generate report showing tran_id, product_id, qty & amt from tran_dtl table..
USE retail;
SELECT * FROM tran_dtl; 
SELECT tran_id, product_id, qty & amt FROM tran_dtl;

-- 10.. Generate report showing tran_id, member-id, store_id & tran_dt from tran_hdr table..
USE retail;
SELECT * FROM tran_hdr;
		        OR
SELECT tran_id, member_id, store_id & tran_dt FROM tran_hdr;           

-- 1 Generate report showing number & transactions per store for each member.(member_id,store1_tran,store2_tran,store3_tran)
SELECT *  FROM tran_hdr;
SELECT *,
sum(CASE WHEN store_id = "1" THEN "1"  ELSE 0 END),
sum(CASE WHEN store_id = "2" THEN "1"  ELSE 0 END),
sum(CASE WHEN store_id = "3" THEN "1"  ELSE 0 END)
FROM tran_hdr
GROUP BY store_id;

-- 2 Generate report showing number of product per category according to product classification.
-- (category,high_value,med_value,low_value,total_products)
select * from product;

select category, count(product_id) as total_products,
sum(CASE WHEN price > 5 THEN 1 else 0   END ) as "high_value",
sum(CASE WHEN price <= 5 and price >=3   THEN 1 else 0 END) as "mid_value",
sum(CASE WHEN price < 3 THEN 1 else 0   END ) as "low_value"
from product 
group by category;

-- 3 Generate report showing number of transactions per member for each quarter 
-- (member_id,qtr1, qtr2, qtr3, qtr4, total_tran)
SELECT * FROM tran_hdr;
 
 SELECT member_id, month(tran_dt), Count(tran_id) AS total_tran,
 sum(CASE WHEN month(tran_dt) IN ("1","2","3") THEN 1 ELSE 0 END) AS "qtr_1",
 sum(CASE WHEN month(tran_dt) IN ("4","5","6") THEN 1 ELSE 0 END) AS "qtr_2",
 sum(CASE WHEN month(tran_dt) IN ("7","8","9") THEN 1 ELSE 0 END) AS "qtr_3",
 sum(CASE WHEN month(tran_dt) IN ("10","11","12") THEN 1 ELSE 0 END) AS "qtr_4"
 FROM tran_hdr th
 GROUP BY member_id;
 
 -- 4 Generate report showing number of transactions per store per qtr
 -- (store_id, stotre_city, qtr1, qtr2, qtr3, qtr4, total_tran)
 
 SELECT th.store_id, count(th.tran_id) AS total_tran, month(th.tran_dt), sd.store_city, 
 sum(CASE WHEN month(th.tran_dt) IN ("1","2","3") THEN 1 ELSE 0 END) AS "qtr_1",
 sum(CASE WHEN month(th.tran_dt) IN ("4","5","6") THEN 1 ELSE 0 END) AS "qtr_2",
 sum(CASE WHEN month(th.tran_dt) IN ("7","8","9") THEN 1 ELSE 0 END) AS "qtr_3",
 sum(CASE WHEN month(th.tran_dt) IN ("10","11","12") THEN 1 ELSE 0 END) AS "qtr_4"
 FROM tran_hdr th
 JOIN store_dtl sd
 ON th.store_id = sd.store_id
 GROUP BY th.store_id;
 
 -- 5 Generate report showing number of transactions per product per store
 -- (product_id, description, st_1_tran, st_2_tran, st_3_tran)
 select a.product_id, a.description, a.store_id, sum(st_1_tran), sum( st_2_tran) ,sum(st_3_tran) from
 (SELECT td.product_id, p.description, th.store_id, count(th.tran_id) AS total_tran,
 sum(CASE WHEN th.store_id = "1" THEN "1" ELSE 0 END) AS "st_1_tran",
 sum(CASE WHEN th.store_id = "2" THEN "1" ELSE 0 END) AS "st_2_tran",
 sum(CASE WHEN th.store_id = "3" THEN "1" ELSE 0 END) AS "st_3_tran"
 FROM tran_dtl td
 JOIN tran_hdr th
 ON td.tran_id = th.tran_id
 JOIN product p
 ON td.product_id = p.product_id
 GROUP BY th.store_id, td.product_id) a
 group by st_1_tran ,st_2_tran , st_3_tran;

 -- 6 Generate report showing total quantity for each product per store 
 -- (product_id, description, st_1_qty, st_2_qty, st_3_qty, total_qty)
 SELECT a.product_id, a.description, a.total_qty, sum(a.s1_qty) as "st_1_qty", sum(a.s2_qty) as "st_2_qty", sum(a.s3_qty) as "st_3_qty" FROM
 (SELECT td.product_id, p.description, sum(td.qty) AS total_qty, th.store_id,
 sum(CASE WHEN th.store_id = "1" THEN "1" ELSE 0 END) AS s1_qty,
 sum(CASE WHEN th.store_id = "2" THEN "1" ELSE 0 END) AS s2_qty,
 sum(CASE WHEN th.store_id = "3" THEN "1" ELSE 0 END) AS s3_qty
 FROM tran_dtl td
 JOIN product p 
 ON td.product_id = p.product_id
 JOIN tran_hdr th
 ON td.tran_id = th.tran_id
 GROUP BY td.product_id, th.store_id) a
 GROUP BY a.product_id;
 
 -- 7 Generate report showing total quantity per category per store
 -- (category,st1_qty, st2_qty, st3_qty)
 SELECT a.total_qty, a.category, a.store_id, sum(a.s1_qty) AS st1_qty, sum(a.s2_qty) AS st2_qty, sum(a.s3_qty) AS st3_qty FROM
 (SELECT sum(td.qty) AS total_qty, p.category, th.store_id,
 sum(CASE WHEN th.store_id = "1" THEN "1" ELSE 0 END) AS s1_qty,
 sum(CASE WHEN th.store_id = "2" THEN "1" ELSE 0 END) AS s2_qty,
 sum(CASE WHEN th.store_id = "3" THEN "1" ELSE 0 END) AS s3_qty
 FROM tran_dtl td
 JOIN product p
 ON td.product_id = p.product_id
 JOIN tran_hdr th
 ON td.tran_id = th.tran_id
 GROUP BY p.category, th.store_id) a;
 
 -- 8 Generate report showing number of members registered per store per quarter
 -- (store_id, store_city, qtr1_reg, qtr2_reg, qtr3_reg, qtr4_reg)
 
 SELECT m.store_id, sd.store_city,
 sum(CASE WHEN MONTH(m.reg_date) IN ("1","2","3") THEN "1" ELSE 0 END) AS "qtr_1_reg",
 sum(CASE WHEN month(m.reg_date) IN ("4","5","6") THEN "1" ELSE 0 END) AS "qtr_2_reg",
 sum(CASE WHEN month(m.reg_date) IN ("7","8","9") THEN "1" ELSE 0 END) AS "qtr_3_reg",
 sum(CASE WHEN month(m.reg_date) IN ("10","11","12") THEN "1" ELSE 0 END) AS "qtr_4_reg"
 FROM member m
 JOIN store_dtl sd
 ON m.store_id = sd.store_id
 GROUP BY m.store_id;
 
 -- 9 Gegenerate report showing total sale for each category per store
 -- (category, st1_sale, st2_sale, st3_sale, total_sale)
 SELECT a.total_sale, a.category, sum(a.st1_sale) AS st1_sale, sum(a.st2_sale) AS st2_sale, sum(a.st3_sale) AS st3_sale FROM
 (SELECT sum(td.amt) AS total_sale, p.category, th.store_id,
 sum(CASE WHEN th.store_id = "1" THEN amt ELSE 0 END) AS st1_sale,
 sum(CASE WHEN th.store_id = "2" THEN amt ELSE 0 END) AS st2_sale,
 sum(CASE WHEN th.store_id = "3" THEN amt ELSE 0 END) AS st3_sale
 FROM tran_dtl td
 JOIN product p 
 ON td.product_id = p.product_id
 JOIN tran_hdr th
 ON td.tran_id = th.tran_id
 GROUP BY p.category, th.store_id) a
 GROUP BY a.category;
 
 -- 10 Generate report showing number of transaction per member per store in which he had purchased cheese
 -- (member_id, first_name, st1_tran, st2_tran, st3_tran)
 
 SELECT m.member_id, m.first_name, a.st1_tran,a.st2_tran, a.st3_tran  FROM member m
 left join
 (SELECT th.member_id, m.first_name,  
 sum(CASE WHEN th.store_id = "1" THEN 1 ELSE 0 END) AS st1_tran,
 sum(CASE WHEN th.store_id = "2" THEN 1 ELSE 0 END) AS st2_tran,
 sum(CASE WHEN th.store_id = "3" THEN 1 ELSE 0 END) AS st3_tran
 FROM tran_dtl td
 JOIN product p
 ON td.product_id = p.product_id
 JOIN tran_hdr th
 ON td.tran_id = th.tran_id
 JOIN member m 
 ON th.member_id = m.member_id
 WHERE p.description= "cheese"
 GROUP BY th.member_id) a
ON m.member_id = a.member_id;

-- 1.. Create new column in student table for standard..
USE standard;
ALTER TABLE student_dtl ADD COLUMN dob VARCHAR (20);

-- 2.. Create new column geography_marks, % of marks in mark table ..
USE standard;
CREATE TABLE mark_dtl (
geography_marks       INT      NOT NULL,
percentage_of_marks     INT        NOT NULL,
PRIMARY KEY (percentage_of_marks)
);

-- 3.. Create new column in wing A & wing B showing number of of family members...
USE family;
INSERT INTO family_members VALUES
("5", "4"),
("6", "3"),
("2", "5");

-- 4.. Create new column no. of guests in Wing A & Wing B table..
USE family;
ALTER TABLE family_members ADD COLUMN no_og_guests INT;

-- 5.. Create new column donor address in donor table..
USE standard;
CREATE TABLE donor (
donor_address      VARCHAR(20)       NOT NULL, 
PRIMARY KEY (donor_address)
);

-- 6..Rename standard column from student to student_std..
USE standard;
ALTER TABLE student_dtl RENAME COLUMN student TO student_std;

-- 7..Rename % of marks from marks table to percent_marks..
USE standard;
ALTER TABLE mark_dtl RENAME percentage_of_marks TO percent_marks;

-- 8.. Rename donor address column from donor table to permanent_address..
ALTER TABLE donor RENAME donor_address TO permanent_address;

-- 9... DROP no. of guests column..
USE family;
ALTER TABLE family_members DROP COLUMN no_of_guests;

-- 10.. DROP permanent_address column..
USE standard;
SELECT * FROM donor; 
DROP TABLE donor;

-- 12... drop shrileela database..
CREATE DATABASE shrileela;
USE shrileela;
DROP DATABASE shrileela;

 

 
 
 
 
 
 
 
 
     
    
    


