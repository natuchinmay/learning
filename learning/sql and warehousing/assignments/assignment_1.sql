USE retail_data;

#1. Generate a report that shows all products all columns

SELECT * FROM product;

#2. Generate a report that shows product_id, description, category for all products belonging to any two categories

SELECT product_id, description, category FROM product;

#3. Generate a report that shows product_id, description for all products.
#4. Generate a report that shows product_id, description for all products.
#7. Generate report showing product_id , description,price from product table.

SELECT product_id, description, category, price FROM product;

#5. Generate report showing member_id,first_name and last_name from member  table.

SELECT member_id, CONCAT(first_name," ",last_name) AS full_name FROM member;

#6. Generate report showing member_id , reg_date and reg_store from member table

SELECT member_id , reg_date, store_id FROM member;

#8. Generate report showing tran_id , qty and amt from tran _dtl table.

SELECT tran_id , qty ,product_id, amt FROM tran _dtl;

#9. Generate report showing tran_id, member_id, store_id and tran_dt from tran_hdr table.

SELECT tran_id, member_id, store_id, tran_dt FROM tran_hdr
