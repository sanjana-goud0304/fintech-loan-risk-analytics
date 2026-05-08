CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date DATE,
    transaction_type VARCHAR(30),
    merchant_category VARCHAR(50),
    amount DECIMAL(10,2),

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);