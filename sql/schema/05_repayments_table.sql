CREATE TABLE repayments (
    repayment_id INT PRIMARY KEY,
    loan_id INT,
    due_date DATE,
    payment_date DATE,
    amount_paid DECIMAL(10,2),
    repayment_status VARCHAR(20),

    FOREIGN KEY (loan_id)
    REFERENCES loans(loan_id)
);