

-- =====================================================
-- MySQL Sales Data Analysis Project
-- Real-time Training Project for Students
-- =====================================================

Project Structure:
Database Schema:

customers - Customer information with segments
products - Product catalog with pricing and inventory
sales_reps - Sales team details with territories
orders - Order transactions with status tracking
order_details - Line items for each order

Key Features:

Sample Data - Realistic dataset with 10 customers, 10 products, 5 sales reps, and 12 orders
10 Progressive Analysis Queries - From basic to advanced
Real-world Scenarios - Monthly trends, customer segmentation, profit analysis
Advanced Database Features - Views, stored procedures, functions, and triggers
Performance Optimization - Proper indexing examples
Student Exercises - 15 practice challenges of varying difficulty

Training Progression:
Beginner Level:

Basic SELECT statements and aggregations
JOIN operations across multiple tables
GROUP BY and ORDER BY clauses

Intermediate Level:

Window functions and subqueries
Date functions and time-based analysis
CASE statements for conditional logic

Advanced Level:

Stored procedures and functions
Triggers for automated updates
Performance optimization with indexes

Real-time Applications:

Sales dashboard creation
Customer lifetime value calculation
Inventory management
Sales team performance tracking
Profit margin analysis

The project is designed to be hands-on and practical, giving students experience with scenarios they will encounter in real business environments. Each query builds upon previous concepts while introducing new MySQL features.

-- Step 1: Create Database
CREATE DATABASE IF NOT EXISTS sales_analytics;
USE sales_analytics;

-- Step 2: Create Tables

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    registration_date DATE,
    customer_segment ENUM('Premium', 'Standard', 'Basic') DEFAULT 'Standard'
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    subcategory VARCHAR(50),
    brand VARCHAR(50),
    unit_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    stock_quantity INT DEFAULT 0,
    launch_date DATE
);

-- Sales Representatives Table
CREATE TABLE sales_reps (
    rep_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    hire_date DATE,
    territory VARCHAR(50),
    commission_rate DECIMAL(4,2) DEFAULT 0.05
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    rep_id INT,
    order_date DATE,
    ship_date DATE,
    order_status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(12,2),
    discount_amount DECIMAL(10,2) DEFAULT 0.00,
    shipping_cost DECIMAL(8,2) DEFAULT 0.00,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (rep_id) REFERENCES sales_reps(rep_id)
);

-- Order Details Table
CREATE TABLE order_details (
    detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2) DEFAULT 0.00,
    line_total DECIMAL(12,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 3: Insert Sample Data

-- Insert Customers
INSERT INTO customers (first_name, last_name, email, phone, city, state, country, registration_date, customer_segment) VALUES
('John', 'Smith', 'john.smith@email.com', '555-0101', 'New York', 'NY', 'USA', '2025-01-15', 'Premium'),
('Sarah', 'Johnson', 'sarah.j@email.com', '555-0102', 'Los Angeles', 'CA', 'USA', '2025-02-20', 'Standard'),
('Mike', 'Brown', 'mike.brown@email.com', '555-0103', 'Chicago', 'IL', 'USA', '2025-03-10', 'Basic'),
('Emma', 'Davis', 'emma.davis@email.com', '555-0104', 'Houston', 'TX', 'USA', '2025-04-05', 'Premium'),
('Robert', 'Wilson', 'r.wilson@email.com', '555-0105', 'Phoenix', 'AZ', 'USA', '2025-05-12', 'Standard'),
('Lisa', 'Garcia', 'lisa.garcia@email.com', '555-0106', 'Philadelphia', 'PA', 'USA', '2025-06-18', 'Premium'),
('David', 'Martinez', 'd.martinez@email.com', '555-0107', 'San Antonio', 'TX', 'USA', '2025-07-22', 'Basic'),
('Maria', 'Anderson', 'maria.a@email.com', '555-0108', 'San Diego', 'CA', 'USA', '2025-08-30', 'Standard'),
('James', 'Taylor', 'james.taylor@email.com', '555-0109', 'Dallas', 'TX', 'USA', '2025-09-14', 'Premium'),
('Jennifer', 'Thomas', 'jen.thomas@email.com', '555-0110', 'San Jose', 'CA', 'USA', '2025-10-25', 'Standard');

-- Insert Products
INSERT INTO products (product_name, category, subcategory, brand, unit_price, cost_price, stock_quantity, launch_date) VALUES
('Wireless Headphones Pro', 'Electronics', 'Audio', 'TechBrand', 199.99, 120.00, 150, '2025-01-01'),
('Smart Phone X1', 'Electronics', 'Mobile', 'PhoneCorp', 899.99, 550.00, 80, '2025-02-15'),
('Laptop Ultra', 'Electronics', 'Computers', 'CompuTech', 1299.99, 800.00, 45, '2025-03-01'),
('Gaming Mouse RGB', 'Electronics', 'Accessories', 'GameGear', 79.99, 45.00, 200, '2025-04-10'),
('4K Monitor 27"', 'Electronics', 'Displays', 'ViewTech', 399.99, 250.00, 75, '2025-05-20'),
('Mechanical Keyboard', 'Electronics', 'Accessories', 'TypeMaster', 149.99, 85.00, 120, '2025-06-05'),
('Wireless Speaker', 'Electronics', 'Audio', 'SoundWave', 129.99, 75.00, 180, '2025-07-12'),
('Tablet Pro 10"', 'Electronics', 'Mobile', 'TabletCorp', 549.99, 350.00, 60, '2025-08-18'),
('Smart Watch Series 5', 'Electronics', 'Wearables', 'WearTech', 299.99, 180.00, 95, '2025-09-25'),
('USB-C Hub', 'Electronics', 'Accessories', 'ConnectPro', 49.99, 25.00, 300, '2025-10-30');

-- Insert Sales Representatives
INSERT INTO sales_reps (first_name, last_name, email, hire_date, territory, commission_rate) VALUES
('Alex', 'Thompson', 'alex.t@company.com', '2022-03-15', 'West Coast', 0.06),
('Jessica', 'Lee', 'jessica.lee@company.com', '2022-07-20', 'East Coast', 0.05),
('Michael', 'Chen', 'michael.chen@company.com', '2022-11-10', 'Central', 0.055),
('Amanda', 'Rodriguez', 'amanda.r@company.com', '2025-01-25', 'South', 0.05),
('Kevin', 'Park', 'kevin.park@company.com', '2025-04-12', 'Northwest', 0.065);

-- Insert Orders
INSERT INTO orders (customer_id, rep_id, order_date, ship_date, order_status, total_amount, discount_amount, shipping_cost) VALUES
(1, 1, '2024-01-15', '2024-01-17', 'Delivered', 1849.97, 50.00, 15.99),
(2, 2, '2024-01-20', '2024-01-22', 'Delivered', 729.98, 20.00, 12.99),
(3, 3, '2024-02-05', '2024-02-07', 'Delivered', 449.98, 0.00, 9.99),
(4, 1, '2024-02-12', '2024-02-14', 'Delivered', 1599.98, 100.00, 19.99),
(5, 4, '2024-02-18', '2024-02-20', 'Delivered', 179.98, 10.00, 8.99),
(6, 2, '2024-03-01', '2024-03-03', 'Delivered', 949.98, 0.00, 15.99),
(7, 5, '2024-03-10', '2024-03-12', 'Delivered', 229.98, 15.00, 7.99),
(8, 3, '2024-03-15', '2024-03-17', 'Delivered', 1199.98, 50.00, 18.99),
(9, 1, '2024-03-22', '2024-03-24', 'Delivered', 849.98, 25.00, 14.99),
(1, 4, '2024-04-05', '2024-04-07', 'Delivered', 329.98, 0.00, 11.99),
(3, 2, '2024-04-12', '2024-04-14', 'Processing', 679.98, 30.00, 13.99),
(5, 5, '2024-04-18', NULL, 'Pending', 799.98, 20.00, 16.99);

-- Insert Order Details
INSERT INTO order_details (order_id, product_id, quantity, unit_price, discount_percent, line_total) VALUES
-- Order 1
(1, 1, 2, 199.99, 5.00, 379.98),
(1, 2, 1, 899.99, 0.00, 899.99),
(1, 4, 3, 79.99, 10.00, 215.97),
(1, 6, 2, 149.99, 0.00, 299.98),
-- Order 2
(2, 3, 1, 1299.99, 15.00, 1104.99),
(2, 5, 1, 399.99, 0.00, 399.99),
-- Order 3
(3, 7, 2, 129.99, 0.00, 259.98),
(3, 9, 1, 299.99, 5.00, 284.99),
-- Order 4
(4, 8, 1, 549.99, 0.00, 549.99),
(4, 1, 3, 199.99, 8.00, 551.97),
-- Order 5
(5, 4, 1, 79.99, 0.00, 79.99),
(5, 10, 2, 49.99, 0.00, 99.98),
-- Continue for remaining orders...
(6, 2, 1, 899.99, 0.00, 899.99),
(6, 10, 1, 49.99, 0.00, 49.99),
(7, 6, 1, 149.99, 0.00, 149.99),
(7, 4, 1, 79.99, 0.00, 79.99),
(8, 3, 1, 1299.99, 0.00, 1299.99),
(9, 1, 2, 199.99, 0.00, 399.98),
(9, 7, 2, 129.99, 0.00, 259.98),
(9, 9, 1, 299.99, 5.00, 284.99),
(10, 7, 1, 129.99, 0.00, 129.99),
(10, 1, 1, 199.99, 0.00, 199.99),
(11, 5, 1, 399.99, 0.00, 399.99),
(11, 6, 2, 149.99, 0.00, 299.98),
(12, 8, 1, 549.99, 0.00, 549.99),
(12, 9, 1, 299.99, 0.00, 299.99);

-- =====================================================
-- ANALYSIS QUERIES - Training Exercises
-- =====================================================

-- Query 1: Basic Sales Summary
SELECT 
    COUNT(DISTINCT order_id) as total_orders,
    COUNT(DISTINCT customer_id) as unique_customers,
    SUM(total_amount) as total_revenue,
    AVG(total_amount) as avg_order_value,
    SUM(discount_amount) as total_discounts
FROM orders 
WHERE order_status = 'Delivered';

-- Query 2: Top Selling Products
SELECT 
    p.product_name,
    p.category,
    SUM(od.quantity) as units_sold,
    SUM(od.line_total) as revenue,
    AVG(od.unit_price) as avg_selling_price
FROM order_details od
JOIN products p ON od.product_id = p.product_id
JOIN orders o ON od.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY revenue DESC;

-- Query 3: Monthly Sales Trend
SELECT 
    YEAR(order_date) as year,
    MONTH(order_date) as month,
    MONTHNAME(order_date) as month_name,
    COUNT(order_id) as orders_count,
    SUM(total_amount) as monthly_revenue,
    AVG(total_amount) as avg_order_value
FROM orders 
WHERE order_status = 'Delivered'
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- Query 4: Customer Segment Analysis
SELECT 
    c.customer_segment,
    COUNT(DISTINCT c.customer_id) as customer_count,
    COUNT(o.order_id) as total_orders,
    SUM(o.total_amount) as total_revenue,
    AVG(o.total_amount) as avg_order_value,
    SUM(o.total_amount) / COUNT(DISTINCT c.customer_id) as revenue_per_customer
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered' OR o.order_status IS NULL
GROUP BY c.customer_segment
ORDER BY total_revenue DESC;

-- Query 5: Sales Rep Performance
SELECT 
    CONCAT(sr.first_name, ' ', sr.last_name) as sales_rep,
    sr.territory,
    COUNT(o.order_id) as orders_handled,
    SUM(o.total_amount) as total_sales,
    AVG(o.total_amount) as avg_deal_size,
    SUM(o.total_amount) * sr.commission_rate as estimated_commission
FROM sales_reps sr
LEFT JOIN orders o ON sr.rep_id = o.rep_id
WHERE o.order_status = 'Delivered' OR o.order_status IS NULL
GROUP BY sr.rep_id, sr.first_name, sr.last_name, sr.territory, sr.commission_rate
ORDER BY total_sales DESC;

-- Query 6: Geographic Sales Distribution
SELECT 
    c.state,
    c.country,
    COUNT(DISTINCT c.customer_id) as customers,
    COUNT(o.order_id) as orders,
    SUM(o.total_amount) as revenue,
    AVG(o.total_amount) as avg_order_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered' OR o.order_status IS NULL
GROUP BY c.state, c.country
HAVING revenue > 0
ORDER BY revenue DESC;

-- Query 7: Product Category Performance
SELECT 
    p.category,
    COUNT(DISTINCT p.product_id) as product_count,
    SUM(od.quantity) as units_sold,
    SUM(od.line_total) as category_revenue,
    AVG(p.unit_price) as avg_product_price,
    SUM(od.line_total) / SUM(od.quantity) as avg_selling_price_per_unit
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
LEFT JOIN orders o ON od.order_id = o.order_id
WHERE o.order_status = 'Delivered' OR o.order_status IS NULL
GROUP BY p.category
HAVING category_revenue > 0
ORDER BY category_revenue DESC;

-- Query 8: Profit Analysis (Advanced)
SELECT 
    p.product_name,
    p.category,
    SUM(od.quantity) as units_sold,
    SUM(od.line_total) as revenue,
    SUM(od.quantity * p.cost_price) as total_cost,
    SUM(od.line_total) - SUM(od.quantity * p.cost_price) as profit,
    ROUND(((SUM(od.line_total) - SUM(od.quantity * p.cost_price)) / SUM(od.line_total)) * 100, 2) as profit_margin_percent
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name, p.category
HAVING units_sold > 0
ORDER BY profit DESC;

-- Query 9: Customer Lifetime Value (CLV)
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) as customer_name,
    c.customer_segment,
    COUNT(o.order_id) as total_orders,
    MIN(o.order_date) as first_order_date,
    MAX(o.order_date) as last_order_date,
    SUM(o.total_amount) as lifetime_value,
    AVG(o.total_amount) as avg_order_value,
    DATEDIFF(MAX(o.order_date), MIN(o.order_date)) as customer_lifespan_days
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.first_name, c.last_name, c.customer_segment
ORDER BY lifetime_value DESC;

-- Query 10: Inventory Status with Sales Performance
SELECT 
    p.product_name,
    p.category,
    p.stock_quantity,
    COALESCE(SUM(od.quantity), 0) as total_sold,
    p.stock_quantity - COALESCE(SUM(od.quantity), 0) as remaining_stock,
    CASE 
        WHEN p.stock_quantity - COALESCE(SUM(od.quantity), 0) < 50 THEN 'Low Stock'
        WHEN p.stock_quantity - COALESCE(SUM(od.quantity), 0) < 100 THEN 'Medium Stock'
        ELSE 'High Stock'
    END as stock_status,
    COALESCE(SUM(od.line_total), 0) as total_revenue
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
LEFT JOIN orders o ON od.order_id = o.order_id AND o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name, p.category, p.stock_quantity
ORDER BY remaining_stock ASC;

-- =====================================================
-- ADVANCED EXERCISES FOR STUDENTS
-- =====================================================

-- Exercise 1: Create a view for monthly sales dashboard
CREATE VIEW monthly_sales_dashboard AS
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') as month_year,
    COUNT(o.order_id) as orders,
    SUM(o.total_amount) as revenue,
    AVG(o.total_amount) as avg_order_value,
    COUNT(DISTINCT o.customer_id) as unique_customers
FROM orders o
WHERE o.order_status = 'Delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month_year;

-- Exercise 2: Create stored procedure for customer analysis
DELIMITER //
CREATE PROCEDURE GetCustomerAnalysis(IN customer_segment_param VARCHAR(20))
BEGIN
    SELECT 
        CONCAT(c.first_name, ' ', c.last_name) as customer_name,
        c.email,
        c.city,
        c.state,
        COUNT(o.order_id) as total_orders,
        SUM(o.total_amount) as total_spent,
        AVG(o.total_amount) as avg_order_value,
        MAX(o.order_date) as last_order_date
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    WHERE c.customer_segment = customer_segment_param 
    AND (o.order_status = 'Delivered' OR o.order_status IS NULL)
    GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city, c.state
    ORDER BY total_spent DESC;
END //
DELIMITER ;

-- Call the procedure: CALL GetCustomerAnalysis('Premium');

-- Exercise 3: Create function to calculate commission
DELIMITER //
CREATE FUNCTION CalculateCommission(sales_amount DECIMAL(12,2), commission_rate DECIMAL(4,2)) 
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    RETURN sales_amount * commission_rate;
END //
DELIMITER ;

-- Exercise 4: Create trigger to update stock quantity
DELIMITER //
CREATE TRIGGER update_stock_after_order
    AFTER INSERT ON order_details
    FOR EACH ROW
BEGIN
    UPDATE products 
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END //
DELIMITER ;

-- =====================================================
-- PERFORMANCE OPTIMIZATION EXAMPLES
-- =====================================================

-- Add indexes for better query performance
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_status ON orders(order_status);
CREATE INDEX idx_order_details_order ON order_details(order_id);
CREATE INDEX idx_order_details_product ON order_details(product_id);
CREATE INDEX idx_customers_segment ON customers(customer_segment);
CREATE INDEX idx_products_category ON products(category);

-- Example of query optimization with EXPLAIN
-- EXPLAIN SELECT * FROM orders WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31';

-- =====================================================
-- REAL-TIME SCENARIOS FOR PRACTICE
-- =====================================================

/*
STUDENT EXERCISES:

1. Find the top 3 customers by total purchase amount
2. Calculate month-over-month growth rate
3. Identify products that haven't been sold
4. Find customers who haven't placed orders in the last 90 days
5. Calculate the conversion rate by sales representative
6. Create a report showing seasonal trends
7. Identify the most profitable product categories
8. Find customers with the highest average order value
9. Calculate inventory turnover ratio
10. Create a dashboard query for executive summary

ADVANCED CHALLENGES:

1. Implement a recommendation system query
2. Create cohort analysis for customer retention
3. Build a forecasting query for next month's sales
4. Implement ABC analysis for inventory management
5. Create a query to detect potential fraudulent orders
*/