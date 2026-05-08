CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    date_of_birth DATE,
    city VARCHAR(50),
    state VARCHAR(50),
    employment_type VARCHAR(30),
    monthly_income DECIMAL(10,2),
    signup_date DATE
);
 
