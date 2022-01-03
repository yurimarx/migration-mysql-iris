DELIMITER ;

-- Set params
set @number_of_sales = 5000;
set @number_of_users = 2500;
set @number_of_products = 200;
set @number_of_stores = 50;
set @number_of_coutries = 100;
set @number_of_cities = 30;
set @status_names = 5;
set @start_date = '2019-01-01 00:00:00';
set @end_date = '2020-02-01 00:00:00';

-- Creation of product table
CREATE TABLE IF NOT EXISTS product (
  product_id INT NOT NULL,
  name varchar(250) NOT NULL,
  PRIMARY KEY (product_id)
);

-- Creation of country table
CREATE TABLE IF NOT EXISTS country (
  country_id INT NOT NULL,
  country_name varchar(450) NOT NULL,
  PRIMARY KEY (country_id)
);

-- Creation of city table
CREATE TABLE IF NOT EXISTS city (
  city_id INT NOT NULL,
  city_name varchar(450) NOT NULL,
  country_id INT NOT NULL,
  PRIMARY KEY (city_id),
  CONSTRAINT fk_country
      FOREIGN KEY(country_id) 
	  REFERENCES country(country_id)
);

-- Creation of store table
CREATE TABLE IF NOT EXISTS store (
  store_id INT NOT NULL,
  name varchar(250) NOT NULL,
  city_id INT NOT NULL,
  PRIMARY KEY (store_id),
  CONSTRAINT fk_city
      FOREIGN KEY(city_id) 
	  REFERENCES city(city_id)
);

-- Creation of user table
CREATE TABLE IF NOT EXISTS users (
  user_id INT NOT NULL,
  name varchar(250) NOT NULL,
  PRIMARY KEY (user_id)
);

-- Creation of status_name table
CREATE TABLE IF NOT EXISTS status_name (
  status_name_id INT NOT NULL,
  status_name varchar(450) NOT NULL,
  PRIMARY KEY (status_name_id)
);

-- Creation of sale table
CREATE TABLE IF NOT EXISTS sale (
  sale_id varchar(200) NOT NULL,
  amount DECIMAL(20,3) NOT NULL,
  date_sale TIMESTAMP,
  product_id INT NOT NULL,
  user_id INT NOT NULL,
  store_id INT NOT NULL, 
  PRIMARY KEY (sale_id),
  CONSTRAINT fk_product
      FOREIGN KEY(product_id) 
	  REFERENCES product(product_id),
  CONSTRAINT fk_user
      FOREIGN KEY(user_id) 
	  REFERENCES users(user_id),
  CONSTRAINT fk_store
      FOREIGN KEY(store_id) 
	  REFERENCES store(store_id)	  
);

-- Creation of order_status table
CREATE TABLE IF NOT EXISTS order_status (
  order_status_id varchar(200) NOT NULL,
  update_at TIMESTAMP,
  sale_id varchar(200) NOT NULL,
  status_name_id INT NOT NULL,
  PRIMARY KEY (order_status_id),
  CONSTRAINT fk_sale
      FOREIGN KEY(sale_id) 
	  REFERENCES sale(sale_id),
  CONSTRAINT fk_status_name
      FOREIGN KEY(status_name_id) 
	  REFERENCES status_name(status_name_id)  
);


DELIMITER $$
-- Filling of countries
DROP PROCEDURE IF EXISTS populate_countries $$
CREATE PROCEDURE populate_countries(amount INT)
BEGIN
	DECLARE x INT DEFAULT 0;
  	loop1: LOOP 
    	SET x = x + 1; 
    	IF x > amount THEN 
      		LEAVE loop1; 
    	END IF; 
    
    INSERT INTO country values(x, concat('Country ', x));

  END LOOP;

END $$

-- Filling of products
DROP PROCEDURE IF EXISTS populate_products $$
CREATE PROCEDURE populate_products(amount INT)
BEGIN
	DECLARE x INT DEFAULT 0;
  	set x = 0; 
  	loop1: LOOP 
  		SET x = x + 1; 
    		IF x > amount THEN
      			LEAVE loop1; 
    	END IF; 
    
    	INSERT INTO product values(x, concat('Product ', x));

	END LOOP;

END $$

-- Filling of cities
DROP PROCEDURE IF EXISTS populate_cities $$
CREATE PROCEDURE populate_cities(amount INT, amount_countries INT)
BEGIN
  	DECLARE x INT DEFAULT 0;
	set x = 0; 
  	loop1: LOOP 
    SET x = x + 1; 
    IF x > amount THEN 
      LEAVE loop1; 
    END IF; 
    
    INSERT INTO city values(x, concat('City ', x), floor(rand() * (amount_countries-1) + 1));

  END LOOP;

END $$

-- Filling of stores
DROP PROCEDURE IF EXISTS populate_stores $$
CREATE PROCEDURE populate_stores(amount INT, amount_cities INT)
BEGIN
  	DECLARE x INT DEFAULT 0;
	set x = 0; 
  	loop1: LOOP 
    SET x = x + 1; 
    IF x > amount THEN 
      LEAVE loop1; 
    END IF; 
    
    INSERT INTO store values(x, concat('Store ', x), floor(rand() * (amount_cities-1)+1));

  END LOOP;

END $$

-- Filling of users
DROP PROCEDURE IF EXISTS populate_users $$
CREATE PROCEDURE populate_users(amount INT)
BEGIN
	DECLARE x INT DEFAULT 0;
  	set x = 0; 
  	loop1: LOOP 
  		SET x = x + 1; 
    		IF x > amount THEN
      			LEAVE loop1; 
    	END IF; 
    
    	INSERT INTO users values(x, concat('User ', x));

	END LOOP;

END $$

-- Filling of status
DROP PROCEDURE IF EXISTS populate_status $$
CREATE PROCEDURE populate_status(amount INT)
BEGIN
	DECLARE x INT DEFAULT 0;
  	set x = 0; 
  	loop1: LOOP 
  		SET x = x + 1; 
    		IF x > amount THEN
      			LEAVE loop1; 
    	END IF; 
    
    	INSERT INTO status_name values(x, concat('Status Name ', x));

	END LOOP;

END $$

-- Filling of sales
DROP PROCEDURE IF EXISTS populate_sales $$
CREATE PROCEDURE populate_sales(amount INT, amount_products INT, amount_users INT, amount_stores INT)
BEGIN
  	DECLARE x INT DEFAULT 0;
	  DECLARE sales_id VARCHAR(200);
	  
    set x = 0; 
  	loop1: LOOP 
    SET x = x + 1; 
    IF x > amount THEN 
      LEAVE loop1; 
    END IF; 
    
    SET sales_id = UUID();
    INSERT INTO sale values(
        sales_id, 
        round(rand() * 10000, 3), 
        ADDDATE(curdate(), floor(rand()*365)), 
        floor(rand() * (amount_products-1) + 1),
        floor(rand() * (amount_users-1) + 1),
        floor(rand() * (amount_stores-1) + 1));

    INSERT INTO order_status values(
      UUID(),
      CURDATE(),
      sales_id,
      floor(rand() * (5-1)+1));
      
  END LOOP;

END $$

DELIMITER ;

-- Set params
set @number_of_sales = 5000;
set @number_of_users = 2500;
set @number_of_products = 200;
set @number_of_stores = 50;
set @number_of_coutries = 100;
set @number_of_cities = 30;
set @status_names = 5;
set @start_date = '2019-01-01 00:00:00';
set @end_date = '2020-02-01 00:00:00';

delete from order_status;
delete from sale;
delete from store;
delete from product;
delete from city;
delete from country;
delete from users;
delete from status_name;

-- Filling of status
call populate_status(@status_names);
-- Filling of countries
call populate_countries(@number_of_coutries);
-- Filling of products
call populate_products(@number_of_products);
-- Filling of cities
call populate_cities(@number_of_cities, @number_of_coutries);
-- Filling of stores
call populate_stores(@number_of_stores, @number_of_cities);
-- Filling of users
call populate_users(@number_of_users);
-- Filling of sale and order status
call populate_sales(@number_of_sales, @number_of_products, @number_of_users, @number_of_stores);
