-- CREATE DATABASE dwh_fp --

-- DROP DATABASE IF EXISTS dwh_fp;
-- CREATE DATABASE dwh_fp;
-- USE dwh_fp;



CREATE SCHEMA [dwh];
GO

-- create dim brand --
CREATE TABLE [dwh].[dim_brand](
	sk_brand VARCHAR(50) NOT NULL PRIMARY KEY,
	brand VARCHAR(50)
);

-- create dim model --
CREATE TABLE [dwh].[dim_model](
	sk_model VARCHAR(50) NOT NULL PRIMARY KEY,
	model VARCHAR(80)
);

-- create dim spec --
CREATE TABLE [dwh].[dim_spec](
	sk_spec VARCHAR(100) NOT NULL PRIMARY KEY,
	transmisi VARCHAR(100),
	power INT,
	engine VARCHAR(80),
	door INT,
	seats INT,
	fuel_type VARCHAR(100),
	color VARCHAR(80)
);

-- create dim location --
CREATE TABLE [dwh].[dim_location] (
	sk_loc INT NOT NULL PRIMARY KEY,
	name VARCHAR(100)
);

-- create dim time --
CREATE TABLE [dwh].[dim_time] (
	sk_time INT NOT NULL PRIMARY KEY,
	year INT
);

-- create fact table orders --
CREATE TABLE [dwh].[fact_orders] (
	sk_orders INT NOT NULL PRIMARY KEY,
	sk_brand VARCHAR(50),
	sk_model VARCHAR(50),
	sk_spec VARCHAR(100),
	sk_time INT,
	sk_location INT,
	mileage INT,
	price BIGINT
);



-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------


-- add foreign key to fact table --
ALTER TABLE [dwh].[fact_orders]
ADD FOREIGN KEY (sk_brand) REFERENCES [dwh].[dim_brand](sk_brand);

ALTER TABLE [dwh].[fact_orders]
ADD FOREIGN KEY (sk_model) REFERENCES [dwh].[dim_model](sk_model);

ALTER TABLE [dwh].[fact_orders]
ADD FOREIGN KEY (sk_spec) REFERENCES [dwh].[dim_spec](sk_spec);

ALTER TABLE [dwh].[fact_orders]
ADD FOREIGN KEY (sk_time) REFERENCES [dwh].[dim_time](sk_time);

ALTER TABLE [dwh].[fact_orders]
ADD FOREIGN KEY (sk_location) REFERENCES [dwh].[dim_location](sk_loc);