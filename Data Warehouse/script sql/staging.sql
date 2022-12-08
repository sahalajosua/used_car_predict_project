-- CREATE DATABASE staging-fp --

DROP DATABASE IF EXISTS staging-fp;
CREATE DATABASE IF NOT EXISTS staging-fp;
USE staging-fp;


CREATE SCHEMA Staging;
GO

DROP TABLE IF EXISTS cars_brand;

-- create table cars_model --
CREATE TABLE [Staging].[cars_brand] (
	brand_id VARCHAR(50) NOT NULL PRIMARY KEY, 
	brand VARCHAR(80)
);

-- create table cars_model --
CREATE TABLE [Staging].[cars_model] (
	model_id VARCHAR(80) NOT NULL PRIMARY KEY,
	brand VARCHAR(80),
	model VARCHAR(80)
);

-- create table cars_specification --
CREATE TABLE [Staging].[cars_specification] (
	spec_id VARCHAR(100) NOT NULL PRIMARY KEY,
	brand VARCHAR(80),
	model VARCHAR(80),
	variant VARCHAR(100),
	transmisi VARCHAR(100),
	power INT,
	engine VARCHAR(80),
	door INT,
	seats INT,
	fuel_type VARCHAR(100),
	color VARCHAR(80)
);

-- create table cars_product --
CREATE TABLE [Staging].[cars_product] (
	display_title TEXT, 
	url TEXT, 
	brand VARCHAR(80), 
	model VARCHAR(80), 
	variant VARCHAR(100), 
	mileage INT,
	transmisi VARCHAR(100), 
	power INT, 
	engine VARCHAR(80), 
	door int, 
	seats INT, 
	fuel_type VARCHAR(80),
	color VARCHAR(80), 
	year INT, 
	province VARCHAR(80), 
	area VARCHAR(80), 
	price bigint
);

-- create table province --
CREATE TABLE [Staging].[province] (
	code INT NOT NULL PRIMARY KEY,
	name VARCHAR(225)
);

-- create table kabupaten --
CREATE TABLE [Staging].[kabupaten] (
	code INT NOT NULL PRIMARY KEY,
	parent_code INT,
	name VARCHAR(100)
);

-- create table kecamatan --
CREATE TABLE [Staging].[kecamatan] (
	code INT NOT NULL PRIMARY KEY,
	parent_code INT,
	name VARCHAR(100)
);
