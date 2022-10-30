USE retail_data;

#	1	Generate report showing total number of transactions at store 2.

SELECT COUNT(tran_id) AS count_tran FROM tran_hdr WHERE store_id =2; 

#	2	Generate report showing average price for baked goods category.

select avg(price) as avg_price, avg(cost) as avg_cost from product ;


select min(price) as min_price, min(cost) as min_cost from product where category = 'beverages' ;

#	4	Generate report showing max price for frozen category.
#	5	Generate report showing total amount of sales for transaction date 2019-08-12.

select sum(amt) as sales_amt from tran_dtl where tran_dt = '2019-08-12'
