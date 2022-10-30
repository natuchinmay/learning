use retail_data;

#	1	Generate report showing monthly sale for each month.
SELECT product_id, year(tran_dt) as year, month(tran_dt) as month, sum(amt) monthly_sale
FROM tran_dtl
GROUP BY product_id,year(tran_dt),month(tran_dt);

#	3	Genetaye report showing total number of transactions per member per month.
select member_id,year(tran_dt) as year, month(tran_dt) as month, count(tran_id) tran_cnt
from tran_hdr group by member_id,year(tran_dt), month(tran_dt);
#	4	Generate report showing total number of transaction per month per store in ascending order.

		select store_id, YEAR(tran_dt) as Yr, month(tran_dt) as tran_month, count(tran_id) as tran_cnt from tran_hdr
        group by store_id,Yr,tran_month   order by count(tran_id) ASC;
	
 
#	5	Generate report showing number of members registered per month per store.

select YEAR(reg_date) as Yr, month(reg_date) as reg_month, store_id,count(member_id) member_cnt
from member group by  YEAR(reg_date), month(reg_date),store_id;
#	6	Generate report showing category wise number of products having price less than 1.
select category,count(product_id) product_cnt from product
where price < 1
group by category;

#select * from product where price < 1;

#	7	Generate report showing total number of transactions per member per store.

select member_id,store_id, count(tran_id) tran_cnt
from tran_hdr group by member_id,store_id;