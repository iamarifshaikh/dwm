-- Create the Dimension Tables with normalization (snowflake schema)
CREATE TABLE DimCategory (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255)
);

CREATE TABLE DimProduct (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES DimCategory(category_id)
);

CREATE TABLE DimLocation (
    location_id INT PRIMARY KEY,
    city VARCHAR(255),
    state VARCHAR(255)
);

CREATE TABLE DimStore (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(255),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES DimLocation(location_id)
);

CREATE TABLE DimCustomer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE DimTime (
    time_id INT PRIMARY KEY,
    date DATE,
    month VARCHAR(50),
    year INT,
    quarter VARCHAR(10)
);

-- Create the Fact Table
CREATE TABLE FactSales (
    sales_id INT PRIMARY KEY,
    product_id INT,
    store_id INT,
    customer_id INT,
    time_id INT,
    quantity_sold INT,
    sales_amount DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES DimProduct(product_id),
    FOREIGN KEY (store_id) REFERENCES DimStore(store_id),
    FOREIGN KEY (customer_id) REFERENCES DimCustomer(customer_id),
    FOREIGN KEY (time_id) REFERENCES DimTime(time_id)
);

-- Insert Data
-- Insert data into DimCategory
INSERT INTO DimCategory VALUES
(1, 'Electronics');

-- Insert data into DimProduct
INSERT INTO DimProduct VALUES
(1, 'Laptop', 1),
(2, 'Smartphone', 1),
(3, 'Tablet', 1);

-- Insert data into DimLocation
INSERT INTO DimLocation VALUES
(1, 'New York', 'NY'),
(2, 'Los Angeles', 'CA'),
(3, 'Chicago', 'IL');

-- Insert data into DimStore
INSERT INTO DimStore VALUES
(1, 'Store A', 1),
(2, 'Store B', 2),
(3, 'Store C', 3);

-- Insert data into DimCustomer
INSERT INTO DimCustomer VALUES
(1, 'John Doe', 35, 'Male'),
(2, 'Jane Smith', 28, 'Female'),
(3, 'Alex Johnson', 42, 'Male');

-- Insert data into DimTime
INSERT INTO DimTime VALUES
(1, '2024-10-23', 'October', 2024, 'Q4'),
(2, '2024-09-15', 'September', 2024, 'Q3'),
(3, '2024-08-10', 'August', 2024, 'Q3');

-- Insert data into FactSales
INSERT INTO FactSales VALUES
(1, 1, 1, 1, 1, 2, 2400.00),
(2, 2, 2, 2, 2, 1, 800.00),
(3, 3, 3, 3, 3, 3, 900.00);

-- Total Sales By Product Category
SELECT C.category_name, SUM(FS.sales_amount) AS total_sales
FROM FactSales FS
JOIN DimProduct P ON FS.product_id = P.product_id
JOIN DimCategory C ON P.category_id = C.category_id
GROUP BY C.category_name;

-- Total Sales By City
SELECT L.city, S.store_name, SUM(FS.sales_amount) AS total_sales
FROM FactSales FS
JOIN DimStore S ON FS.store_id = S.store_id
JOIN DimLocation L ON S.location_id = L.location_id
GROUP BY L.city, S.store_name;
