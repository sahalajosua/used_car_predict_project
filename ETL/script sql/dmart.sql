-- CREATE DATABASE dwh_fp --

-- DROP DATABASE IF EXISTS dwh_fp;
-- CREATE DATABASE dwh_fp;
-- USE dwh_fp;



CREATE SCHEMA dmart;
GO

-- create table data mart prediction --
CREATE TABLE [dmart].[prediction] (
	order_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	brand VARCHAR(50),
	model VARCHAR(50),
	transmisi VARCHAR(100),
	power INT,
	engine VARCHAR(80),
	door INT,
	seats INT,
	fuel_type VARCHAR(100),
	color VARCHAR(80),
	mileage INT,
	year INT,
	province VARCHAR(100),
	price BIGINT
);


-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------


-- insert into table data mart prediction --
INSERT INTO [dmart].[prediction] ( 
	brand, 
	model, 
	transmisi, 
	power, 
	engine, 
	door, 
	seats, 
	fuel_type, 
	color, 
	mileage, 
	year, 
	province, 
	price)
SELECT i.brand, i.model, i.transmisi, i.power, i.engine, i.door, i.seats, i.fuel_type, i.color, i.mileage, i.year, j.name, i.price
FROM
	(SELECT g.order_id, g.brand, g.model, g.transmisi, g.power, g.engine, g.door, g.seats, g.fuel_type, g.color, year, g.sk_location, g.mileage, g.price
	FROM	
		(SELECT e.order_id, e.brand, e.model, transmisi, power, engine, door, seats, fuel_type, color, e.sk_time, e.sk_location, e.mileage, e.price
		FROM	
			(SELECT c.order_id, c.brand, d.model, c.sk_spec, c.sk_time, c.sk_location, c.mileage, c.price
			FROM
				(SELECT sk_orders AS order_id, brand, sk_model, sk_spec, sk_time, sk_location, mileage, price
				FROM [dwh].[fact_orders] AS a
				LEFT JOIN [dwh].[dim_brand] as b
				ON a.sk_brand = b.sk_brand) as c
			LEFT JOIN [dwh].[dim_model] AS d
			ON c.sk_model = d.sk_model) AS e
		LEFT JOIN [dwh].[dim_spec] AS f
		ON e.sk_spec = f.sk_spec) AS g
	LEFT JOIN [dwh].[dim_time] AS h
	ON g.sk_time = h.sk_time) AS i
LEFT JOIN [dwh].[dim_location] AS j
ON i.sk_location = j.sk_loc;