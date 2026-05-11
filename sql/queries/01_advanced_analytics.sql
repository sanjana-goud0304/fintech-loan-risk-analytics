/*SECTION 1 — BUSINESS KPI QUERIES*/

/*QUERY 1 — Total Loan Portfolio*/
SELECT
	COUNT(*) AS total_loans,
    ROUND(SUM(loan_amount),2) as total_portfolio_value,
    ROUND(AVG(loan_amount),2) AS avg_loan_amount
FROM loans;

/*QUERY 2 — Default Rate KPI*/
SELECT
	ROUND(SUM(
		CASE
			WHEN loan_status = 'Default' THEN 1
            ELSE 0
            END
		) * 100 / COUNT(*),
		2)AS default_rate_percentage	
FROM loans;

/*QUERY 3 — Repayment Performance KPI*/
SELECT
	repayment_status,
	count(*) as total_payements,
    ROUND(count(*)*100/(select count(*) from repayments),2) AS percentage
FROM repayments
GROUP BY repayment_status;

/*SECTION 2 — CUSTOMER SEGMENTATION*/

/*QUERY 4 — Income Segmentation*/
SELECT
	CASE
		WHEN monthly_income < 50000 THEN 'Low_income'
        WHEN monthly_income BETWEEN 50000 AND 100000 THEN 'Middle_income'
        ELSE 'High_income'
        END AS customer_segment,
        count(*) AS total_customers
FROM customers
GROUP BY customer_segment;

/*QUERY 5 — High Value Customers*/
SELECT
	c.customer_id,
    c.first_name,
    c.last_name,
    SUM(l.loan_amount) as total_loan
FROM customers c
JOIN loans l
ON c.customer_id = l.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name
ORDER BY total_loan DESC;

/*SECTION 3 — ADVANCED JOIN ANALYTICS*/

/*QUERY 6 — Missed Payment Risk Analysis*/
SELECT
	c.customer_id,
    c.first_name,
    c.last_name,
    count(*) as missed_payments
FROM customers c
JOIN loans l
ON c.customer_id = l.customer_id

JOIN repayments r
ON l.loan_id = r.loan_id

WHERE r.repayment_status = 'Missed'
GROUP BY c.customer_id,c.first_name,c.last_name
HAVING count(*) >= 2
ORDER BY missed_payments DESC
LIMIT 10;

/*SECTION 4 — CTEs (COMMON TABLE EXPRESSIONS)*/

/*QUERY 7 — Top Risk Customers Using CTE*/
WITH customer_risk AS(
	SELECT
		c.customer_id,
		c.first_name,
		c.last_name,
		count(*) as missed_payments
	FROM customers c
	JOIN loans l
	ON c.customer_id = l.customer_id
	JOIN repayments r
	ON l.loan_id = r.loan_id
	WHERE r.repayment_status = 'Missed'
	GROUP BY c.customer_id,c.first_name,c.last_name
) 
SELECT * 
FROM customer_risk
WHERE missed_payments >=2
ORDER BY missed_payments DESC;

/*SECTION 5 — WINDOW FUNCTIONS 🚀*/

/*QUERY 8 — Rank Customers By Loan Amount*/
SELECT
	customer_id,
    loan_amount,
    RANK() OVER(
			ORDER BY loan_amount DESC
		) AS loan_rank
FROM loans
LIMIT 10;

/*QUERY 9 — Running Total Of Loans*/
SELECT 
	customer_id,
    loan_amount,
    SUM(loan_amount) OVER(
    ORDER BY loan_amount
    ) AS running_total
FROM loans;

/*SECTION 6 — FRAUD DETECTION STYLE ANALYSIS*/

/*QUERY 10 — Suspicious High Transaction Customers*/
SELECT
	customer_id,
    count(*) AS total_transactions,
    SUM(amount) AS total_amount 
FROM transactions
GROUP BY customer_id
HAVING total_amount > 1000000
ORDER BY total_amount DESC;