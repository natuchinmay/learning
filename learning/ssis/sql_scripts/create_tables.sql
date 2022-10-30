CREATE DATABASE retail_data;

GO

USE retail_data;

CREATE TABLE product 	 (
    product_id   INT             NOT NULL,
    description  VARCHAR(40)     NOT NULL,
    price  		 FLOAT           NOT NULL,
	cost  		 FLOAT           NOT NULL,
    subcategory  VARCHAR(40)     NOT NULL,
    category     VARCHAR(40)     NOT NULL,
	brand        VARCHAR(40)     NOT NULL,
	max_qty      INT	         NOT NULL,
    price_cat    VARCHAR(40)     NOT NULL,
	ipi_days	 INT             NOT NULL,
	percent_disc FLOAT           NOT NULL,
    PRIMARY KEY (product_id)
);


CREATE TABLE tran_hdr (
   tran_id   VARCHAR(70)     NOT NULL,
   store_id  INT             NOT NULL,
   member_id INT             NOT NULL,
   tran_dt   DATE            NOT NULL,
   PRIMARY KEY(tran_id, tran_dt)
);

CREATE TABLE tran_dtl (
   tran_id      VARCHAR(70)     NOT NULL,
   product_id   INT             NOT NULL,
   qty          INT             NOT NULL,
   amt          FLOAT           NOT NULL,
   tran_dt      DATE            NOT NULL,
   PRIMARY KEY(tran_id,product_id,tran_dt)
);

CREATE TABLE member (
    member_id   INT             NOT NULL,
    first_name  VARCHAR(20)     NOT NULL,
    last_name   VARCHAR(20)     NOT NULL,
    store_id    INT             NOT NULL,
    reg_date    DATE            NOT NULL,
    PRIMARY KEY (member_id)
);

