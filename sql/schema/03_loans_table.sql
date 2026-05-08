CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    tenure_months INT,
    loan_status VARCHAR(20),
    disbursement_date DATE,

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);