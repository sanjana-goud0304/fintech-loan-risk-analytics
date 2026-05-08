CREATE TABLE credit_scores (
    score_id INT PRIMARY KEY,
    customer_id INT,
    credit_score INT,
    score_date DATE,

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);