-- CREATE DATABASE staging-fp --

-- DROP DATABASE IF EXISTS "staging-fp";
-- CREATE DATABASE "staging-fp";
-- USE "staging-fp";



CREATE SCHEMA [oltp];
GO

-- update table cars_product in schema Staging --
UPDATE
  [Staging].[cars_product]
SET
  province = UPPER(province);

-- create table cars_brand --
CREATE TABLE [oltp].[cars_brand] (
	brand_id VARCHAR(50) NOT NULL PRIMARY KEY, 
	brand VARCHAR(80)
);

-- create table cars_model
CREATE TABLE [oltp].[cars_model] (
	model_id VARCHAR(80) NOT NULL PRIMARY KEY,
	brand_id VARCHAR(50),
	model VARCHAR(100)
);

-- create table cars_spec --
CREATE TABLE [oltp].[cars_spec] (
	spec_id VARCHAR(100) NOT NULL PRIMARY KEY,
	brand_id VARCHAR(50),
	model_id VARCHAR(80),
	transmisi VARCHAR(100),
	power INT,
	engine VARCHAR(80),
	door INT,
	seats INT,
	fuel_type VARCHAR(100),
	color VARCHAR(80)
);

-- create table province --
CREATE TABLE [oltp].[province] (
	id INT NOT NULL PRIMARY KEY,
	name VARCHAR(100)
);

-- create table kabupaten --
CREATE TABLE [oltp].[kabupaten] (
	id INT NOT NULL PRIMARY KEY,
	parent_code INT,
	name VARCHAR(100)
);

-- create table kecamatan --
CREATE TABLE [oltp].[kecamatan] (
	id INT NOT NULL PRIMARY KEY,
	parent_code INT,
	name VARCHAR(100)
);

-- create table cars_order with auto increment --
CREATE TABLE [oltp].[cars_order] (
	prod_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	display_title VARCHAR(MAX), 
	url VARCHAR(MAX), 
	brand_id VARCHAR(50), 
	model_id VARCHAR(80),
	spec_id VARCHAR(100), 
	mileage INT,
	year_id INT, 
	prov_id INT, 
	area VARCHAR(100), 
	price BIGINT
);

-- create table time --
CREATE TABLE [oltp].[time] (
    id INT IDENTITY(1,1) PRIMARY KEY,
    year INT
);


-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------


-- insert into table cars_brand --
INSERT INTO [oltp].[cars_brand] (
	brand_id,
	brand)
SELECT brand_id, brand
FROM [Staging].[cars_brand];

-- insert into table cars_model --
INSERT INTO [oltp].[cars_model] (
	model_id, 
	brand_id, 
	model)
SELECT a.model_id, b.brand_id, a.model
FROM [Staging].[cars_model] AS a
LEFT JOIN [Staging].[cars_brand] AS b
ON a.brand = b.brand;

-- insert into cars_spec --
INSERT INTO [oltp].[cars_spec] 
	(spec_id, brand_id, model_id, transmisi, power, engine, door, seats, fuel_type, color)
SELECT 
	p.spec_id, p.brand_id, t.model_id, p.transmisi, p.power, p.engine, p.door, p.seats, p.fuel_type, p.color
FROM
	(SELECT 
		a.spec_id, 
		b.brand_id, 
		a.brand, 
		a.model, 
		a.variant, 
		a.transmisi, 
		a.power, 
		a.engine, 
		a.door, 
		a.seats, 
		a.fuel_type, 
		a.color
	FROM [Staging].[cars_specification] AS a
	LEFT JOIN [Staging].[cars_brand] AS b
	ON a.brand = b.brand) AS p
LEFT JOIN [Staging].[cars_model] AS t
ON p.brand = t.brand and p.model = t.model;

-- insert into table province --
INSERT INTO [oltp].[province] (id, name)
SELECT code, name
FROM [Staging].[province];

-- insert into table kabupaten --
INSERT INTO [oltp].[kabupaten] (id, parent_code, name)
SELECT code, parent_code, name
FROM [Staging].[kabupaten];

-- insert into table kecamatan --
INSERT INTO [oltp].[kecamatan] (id, parent_code, name)
SELECT code, parent_code, name
FROM [Staging].[kecamatan];

-- insert value to table time --
INSERT INTO [oltp].[time] (year)
VALUES 
	(1950),
	(1951),
	(1952),
	(1953),
	(1954),
	(1955),
	(1956),
	(1957),
	(1958),
	(1959),
	(1960),
	(1961),
	(1962),
	(1963),
	(1964),
	(1965),
	(1966),
	(1967),
	(1968),
	(1969),
	(1970),
	(1971),
	(1972),
	(1973),
	(1974),
	(1975),
	(1976),
	(1977),
	(1978),
	(1979),
	(1980),
	(1981),
	(1982),
	(1983),
	(1984),
	(1985),
	(1986),
	(1987),
	(1988),
	(1989),
	(1990),
	(1991),
	(1992),
	(1993),
	(1994),
	(1995),
	(1996),
	(1997),
	(1998),
	(1999),
	(2000),
	(2001),
	(2002),
	(2003),
	(2004),
	(2005),
	(2006),
	(2007),
	(2008),
	(2009),
	(2010),
	(2011),
	(2012),
	(2013),
	(2014),
	(2015),
	(2016),
	(2017),
	(2018),
	(2019),
	(2020),
	(2021),
	(2022),
	(2023),
	(2024),
	(2025),
	(2026),
	(2027),
	(2028),
	(2029),
	(2030);

-- insert into table products --
INSERT INTO [oltp].[cars_order] (
	display_title, 
	url, 
	brand_id, 
	model_id,
	spec_id,
	mileage,
	year_id, 
	prov_id, 
	area, 
	price)
SELECT
		h.dis_title,
		h.url1,
		h.brand_id,
		h.model_id,
		h.spec_id,
		h.mileage,
		i.id AS year_id,
		h.prov_id,
		h.area,
		h.price
FROM
	(SELECT 
		f.dis_title,
		f.url1,
		f.brand_id,
		f.model_id,
		f.spec_id,
		f.mileage,
		f.year,
		g.id as prov_id,
		f.area,
		f.price
	FROM
		(SELECT 
			CONVERT(VARCHAR(MAX),d.display_title) as dis_title,
			CONVERT(VARCHAR(MAX),d.url) as url1,
			d.brand_id,
			d.model_id,
			e.spec_id,
			d.mileage,
			d.year,
			d.province,
			d.area,
			d.price
		FROM
			(SELECT
				c.display_title, 
				c.url,
				c.brand_id, 
				d.model_id, 
				c.mileage,
				c.transmisi, 
				c.power, 
				c.engine, 
				c.door, 
				c.seats, 
				c.fuel_type, 
				c.color, 
				c.year, 
				c.province, 
				c.area, 
				c.price
			FROM
				(SELECT 
					a.display_title, 
					a.url,
					b.brand_id, 
					a.model,  
					a.mileage,
					a.transmisi, 
					a.power, 
					a.engine, 
					a.door, 
					a.seats, 
					a.fuel_type, 
					a.color, 
					a.year, 
					a.province, 
					a.area, 
					a.price
				FROM [Staging].[cars_product] AS a
				LEFT JOIN [oltp].[cars_brand] AS b
				ON a.brand = b.brand) AS c
			LEFT JOIN [oltp].[cars_model] AS d
			ON 
				c.brand_id = d.brand_id 
				AND c.model = d.model) AS d
		LEFT JOIN [oltp].[cars_spec] AS e
		ON 
			d.brand_id = e.brand_id 
			AND d.model_id = e.model_id 
			AND d.transmisi = e.transmisi 
			AND d.power = e.power 
			AND d.engine = e.engine 
			AND d.door = e.door 
			AND d.seats = e.seats 
			AND d.fuel_type = e.fuel_type 
			AND d.color = e.color
		GROUP BY 
				CONVERT(VARCHAR(MAX),d.display_title), CONVERT(VARCHAR(MAX),d.url), 
				d.brand_id, d.model_id, e.spec_id, d.mileage, d.year, d.province, d.area, d.price) AS f
	LEFT JOIN [oltp].[province] AS g
	ON f.province = g.name) AS h
LEFT JOIN [oltp].[time] AS i
ON h.year = i.year
GROUP BY h.dis_title, h.url1, h.brand_id, h.model_id, h.spec_id, h.mileage, i.id, h.prov_id, h.area, h.price
ORDER BY NEWID();


-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------


-- add foreign key to table area --
ALTER TABLE [oltp].[kecamatan]
ADD FOREIGN KEY (parent_code) REFERENCES [oltp].[kabupaten](id);

ALTER TABLE [oltp].[kabupaten]
ADD FOREIGN KEY (parent_code) REFERENCES [oltp].[province](id);

-- add foreign key to multiple table cars on schema oltp --
ALTER TABLE [oltp].[cars_spec]
ADD FOREIGN KEY (brand_id) REFERENCES [oltp].[cars_brand](brand_id);

ALTER TABLE [oltp].[cars_spec]
ADD FOREIGN KEY (model_id) REFERENCES [oltp].[cars_model](model_id);

ALTER TABLE [oltp].[cars_model]
ADD FOREIGN KEY (brand_id) REFERENCES [oltp].[cars_brand](brand_id);

-- add foreign key to table cars_order on schema oltp --
ALTER TABLE [oltp].[cars_order]
ADD FOREIGN KEY (brand_id) REFERENCES [oltp].[cars_brand](brand_id);

ALTER TABLE [oltp].[cars_order]
ADD FOREIGN KEY (model_id) REFERENCES [oltp].[cars_model](model_id);

ALTER TABLE [oltp].[cars_order]
ADD FOREIGN KEY (spec_id) REFERENCES [oltp].[cars_spec](spec_id);

ALTER TABLE [oltp].[cars_order]
ADD FOREIGN KEY (prov_id) REFERENCES [oltp].[province](id);

ALTER TABLE [oltp].[cars_order]
ADD FOREIGN KEY (year_id) REFERENCES [oltp].[time](id);

