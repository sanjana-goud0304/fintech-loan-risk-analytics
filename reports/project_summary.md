# FinTech Loan Risk & Customer Analytics

## End-to-End Data Analytics & Business Intelligence Project

---

# 1. Project Overview

The FinTech Loan Risk & Customer Analytics project is an end-to-end analytics and business intelligence solution designed to analyze customer lending behavior, repayment performance, financial risk indicators, and portfolio health for a financial lending institution.

The project combines:

* SQL analytics
* Python exploratory data analysis (EDA)
* Feature engineering
* KPI engineering
* Data visualization
* Interactive Power BI dashboards

The objective of this project is to help financial institutions make smarter, data-driven lending decisions by identifying high-risk customers, monitoring repayment behavior, analyzing portfolio performance, and improving financial reporting.

---

# 2. Business Problem

Financial institutions face several operational and analytical challenges while managing loan portfolios and customer repayment systems.

Some of the major business problems include:

* Increasing loan default rates
* Lack of visibility into customer repayment behavior
* Difficulty identifying risky borrowers early
* Poor customer segmentation strategies
* Limited portfolio monitoring capabilities
* Inefficient manual reporting processes
* Inability to analyze branch-level lending performance
* Limited insight into customer transaction behavior

Without proper analytics systems, financial institutions may:

* Approve loans for high-risk customers
* Experience higher repayment failures
* Increase financial losses due to defaults
* Miss opportunities to optimize lending strategies
* Struggle to monitor portfolio health efficiently

This project solves these problems by building a complete analytics workflow capable of generating actionable business insights through SQL, Python, and Power BI.

---

# 3. Project Objectives

The major objectives of this project are:

* Analyze customer loan behavior
* Monitor repayment performance
* Identify high-risk customers
* Track missed payment trends
* Build customer segmentation models
* Measure portfolio health
* Create executive-level KPI dashboards
* Improve lending visibility using business intelligence

---

# 4. Project Architecture

The project follows a complete end-to-end analytics workflow.

## Workflow Pipeline

Raw CSV Data
↓
MySQL Database
↓
SQL Analytics
↓
Python EDA & Feature Engineering
↓
Cleaned Datasets
↓
Power BI Dashboards
↓
Business Insights & Reporting

---

# 5. Tools & Technologies Used

| Tool / Technology | Purpose                               |
| ----------------- | ------------------------------------- |
| Python            | Data analysis and feature engineering |
| Pandas            | Data cleaning and manipulation        |
| NumPy             | Numerical operations                  |
| Matplotlib        | Data visualization                    |
| SQL               | Data querying and analytics           |
| MySQL             | Relational database management        |
| Power BI          | Interactive dashboards and reporting  |
| Jupyter Notebook  | Analysis environment                  |
| CSV / Excel       | Data storage and import               |
| Git & GitHub      | Version control and project managem   |


# 6. Database Design

The project uses a relational database architecture with interconnected tables designed to simulate real-world financial lending operations.

The database contains customer, loan, repayment, transaction, and credit score information to support loan risk analysis, repayment monitoring, customer segmentation, and portfolio analytics.

---

# Main Tables

## 1. Customers Table

Stores customer demographic and income-related information.

| Column Name     | Description                                      |
| --------------- | ------------------------------------------------ |
| customer_id     | Unique customer identifier                       |
| first_name      | Customer first name                              |
| last_name       | Customer last name                               |
| gender          | Customer gender                                  |
| date_of_birth   | Customer DOB                                     |
| city            | Customer city                                    |
| state           | Customer state                                   |
| employment_type | Salaried / Freelancer / Business / Self-Employed |
| monthly_income  | Monthly customer income                          |
| signup_date     | Customer registration date                       |

---

## 2. Loans Table

Stores loan-related information issued to customers.

| Column Name       | Description                  |
| ----------------- | ---------------------------- |
| loan_id           | Unique loan identifier       |
| customer_id       | Linked customer ID           |
| loan_amount       | Total sanctioned loan amount |
| interest_rate     | Loan interest rate           |
| tenure_months     | Loan duration in months      |
| loan_status       | Active / Closed / Default    |
| disbursement_date | Loan issue date              |

---

## 3. Transactions Table

Stores customer transaction activity used for spending behavior and financial analysis.

| Column Name       | Description                   |
| ----------------- | ----------------------------- |
| transaction_id    | Unique transaction identifier |
| customer_id       | Linked customer ID            |
| transaction_date  | Transaction date              |
| transaction_type  | Credit / Debit                |
| merchant_category | Merchant spending category    |
| amount            | Transaction amount            |

---

## 4. Repayments Table

Tracks loan repayment activity and repayment performance.

| Column Name      | Description                 |
| ---------------- | --------------------------- |
| repayment_id     | Unique repayment identifier |
| loan_id          | Associated loan ID          |
| due_date         | Expected repayment due date |
| payment_date     | Actual payment date         |
| amount_paid      | Repayment amount paid       |
| repayment_status | On-Time / Late / Missed     |

---

## 5. Credit Scores Table

Stores customer credit score history for risk analysis.

| Column Name  | Description                  |
| ------------ | ---------------------------- |
| score_id     | Unique score identifier      |
| customer_id  | Linked customer ID           |
| credit_score | Customer credit score        |
| score_date   | Credit score evaluation date |

---

# Entity Relationship Overview

The database follows a relational structure with primary and foreign key relationships.

## Relationships

* One customer can have multiple loans.
* One customer can perform multiple transactions.
* One customer can have multiple credit score records over time.
* One loan can have multiple repayment records.
* Customer IDs and Loan IDs act as relational keys across tables.

---

# Relational Key Structure

| Parent Table | Child Table   | Relationship |
| ------------ | ------------- | ------------ |
| customers    | loans         | customer_id  |
| customers    | transactions  | customer_id  |
| customers    | credit_scores | customer_id  |
| loans        | repayments    | loan_id      |

---

# Database Design Purpose

The database structure was designed to support:

* Loan portfolio analytics
* Repayment monitoring
* Customer segmentation
* Credit risk analysis
* Transaction behavior analysis
* KPI engineering
* Power BI reporting
* Financial business intelligence

# 7. Data Generation & Preparation

Synthetic financial datasets were generated using Python and the Faker library.

The datasets included:

* Customer profiles
* Loan records
* Repayment transactions
* Banking transactions
* Credit score information

The generated data simulated realistic financial lending behavior for analytical purposes.

The datasets were exported as CSV files and imported into MySQL for relational analysis.

---

# 8. SQL Analytics

SQL was used extensively to perform business analysis, KPI extraction, customer segmentation, and repayment monitoring.

## SQL Operations Performed

* JOINS
* GROUP BY aggregations
* CASE statements
* Window functions
* Ranking analysis
* Trend analysis
* Customer segmentation

---

## Customer Loan Summary

```sql
SELECT
    customer_id,
    COUNT(loan_id) AS total_loans,
    SUM(loan_amount) AS total_loan_amount
FROM loans
GROUP BY customer_id;
```

---

## Missed Payment Analysis

```sql
SELECT
    repayment_status,
    COUNT(*) AS total_count
FROM repayments
GROUP BY repayment_status;
```

---

## Employment-wise Loan Analysis

```sql
SELECT
    c.employment_type,
    AVG(l.loan_amount) AS avg_loan_amount
FROM customers c
JOIN loans l
ON c.customer_id = l.customer_id
GROUP BY c.employment_type;
```

---

# Window Function Analysis

## Loan Ranking by Branch

```sql
SELECT
    customer_id,
    loan_amount,
    DENSE_RANK() OVER(
        ORDER BY loan_amount DESC
    ) AS loan_rank
FROM loans;
```

---

## Previous Transaction Analysis Using LAG()

```sql
SELECT
    customer_id,
    transaction_date,
    amount,
    LAG(amount) OVER(
        PARTITION BY customer_id
        ORDER BY transaction_date
    ) AS previous_transaction
FROM transactions;
```

---

## Future Repayment Analysis Using LEAD()

```sql
SELECT
    loan_id,
    repayment_date,
    repayment_amount,
    LEAD(repayment_amount) OVER(
        PARTITION BY loan_id
        ORDER BY repayment_date
    ) AS next_payment
FROM repayments;
```

---

# 9. Python Exploratory Data Analysis (EDA)

Python EDA was performed using Pandas, NumPy, and Matplotlib.

The objective of EDA was to:

* Understand customer behavior
* Analyze repayment trends
* Detect risk patterns
* Explore loan distributions
* Generate business KPIs

---

# Data Cleaning

The following cleaning operations were performed:

* Removed duplicate records
* Fixed missing values
* Converted date columns to datetime format
* Standardized column names
* Corrected inconsistent repayment labels
* Fixed formatting inconsistencies

---

# Data Exploration

The project included:

* Distribution analysis
* Correlation analysis
* Loan portfolio analysis
* Income segmentation
* Risk analysis
* Repayment analysis
* Customer behavior analysis

---

# Sample Pandas Operations

## Customer Loan Aggregation

```python
customer_loans = (
    loans.groupby('customer_id')['loan_amount']
    .sum()
)
```

---

## Missed Payment Customers

```python
missed_payments = repayments[
    repayments['repayment_status'] == 'Missed'
]
```

---

## Customer Spending Analysis

```python
customer_spending = (
    transactions.groupby('customer_id')['amount']
    .sum()
    .sort_values(ascending=False)
)
```

---

# 10. Feature Engineering

Several business-focused features were engineered to improve analytical insights.

---

# High Risk Flag

Customers with repeated missed repayments were classified as high risk.

```python
customer_loan_analytics['high_risk_flag'] = np.where(
    customer_loan_analytics['missed_payment_flag'] > 2,
    1,
    0
)
```

---

# Income Segmentation

Customers were categorized into income groups:

* Low Income
* Middle Income
* High Income

This improved customer segmentation analysis.

---

# Repayment Ratio

Repayment Ratio = Total Repaid Amount / Total Loan Amount × 100

---

# Loan-to-Income Ratio

Loan-to-Income Ratio = Loan Amount / Monthly Income

This helps identify customers with excessive borrowing exposure.

---

# Missed Payment Percentage

Missed Payment Percentage = Missed Payments / Total Payments × 100

Used to measure repayment reliability.

---

# 11. KPI Engineering

Several business KPIs were engineered for dashboard reporting.

| KPI                      | Description                     |
| ------------------------ | ------------------------------- |
| Total Customers          | Total customer count            |
| Total Loan Portfolio     | Overall loan value              |
| Average Loan Amount      | Average sanctioned loan         |
| Default Rate             | Percentage of default loans     |
| Missed Payment Rate      | Percentage of missed repayments |
| High Risk Customers      | Count of risky customers        |
| On-Time Payments         | Successful repayments           |
| Repayment Success Rate   | Repayment efficiency            |
| Income Segment Analysis  | Customer segmentation KPI       |
| Employment Risk Analysis | Employment-wise risk exposure   |

---

# 12. Power BI Dashboards

Interactive Power BI dashboards were created for executive-level reporting.

The dashboards include:

* KPI cards
* Risk analysis
* Customer segmentation
* Repayment monitoring
* Interactive filters
* Time-series analytics
* Portfolio performance analysis

---

# Executive Overview Dashboard

## Focus Areas

* Total loan portfolio
* Total customers
* Default rate
* Missed payment rate
* Loan distribution
* Employment-wise loan analysis

---

# Customer Segmentation Dashboard

## Focus Areas

* Income segmentation
* Employment distribution
* Customer behavior analysis
* Monthly income analysis
* Customer risk categorization

---

# Loan Risk Analysis Dashboard

## Focus Areas

* High-risk customers
* Default loan analysis
* Missed payment trends
* State-level risk exposure
* Employment risk segmentation

---

# Repayment & Collection Analytics Dashboard

## Focus Areas

* On-time payments
* Late payments
* Missed payments
* Repayment trends
* Collection efficiency
* Repayment segmentation

---

# 13. Key Business Insights

## Active Loans Dominate the Portfolio

The majority of loans remained active, indicating strong customer engagement and portfolio growth.

---

## Missed Payments Remain Moderately High

A significant percentage of customers showed delayed or missed repayments, highlighting repayment risk exposure.

---

## Employment Type Influences Risk

Certain employment categories demonstrated higher repayment risk and missed payment frequency.

---

## Income Directly Impacts Repayment Ability

Lower-income customers showed:

* Higher missed payments
* Increased repayment delays
* Greater financial risk exposure

---

## High-Risk Customers Were Successfully Identified

Risk segmentation techniques successfully identified customers with higher default probability.

---

## Repayment Trends Vary Across Customer Segments

Repayment consistency varied significantly across:

* Income groups
* Employment types
* Customer risk categories

---

# 14. Challenges Faced During the Project

Several real-world development challenges were encountered during the project.

## Challenges Included

* MySQL foreign key constraints
* Data cleaning inconsistencies
* Missing repayment values
* Power BI relationship management
* DAX measure formatting
* Incorrect aggregations in dashboards
* Environment and package management issues
* Kernel configuration issues in Jupyter Notebook

These challenges helped improve problem-solving and debugging skills.

---

# 15. Future Improvements

Several future enhancements can improve the project further.

---

# Machine Learning Risk Prediction

Future models may include:

* Logistic Regression
* Random Forest
* XGBoost
* Credit scoring models

To predict:

* Loan defaults
* Repayment probability
* Customer creditworthiness

---

# Real-Time Dashboard Integration

Integrate dashboards with:

* APIs
* Cloud databases
* Streaming pipelines

For real-time business intelligence.

---

# Fraud Detection System

Build anomaly detection systems to identify:

* Suspicious transactions
* Fraudulent behavior
* Unusual repayment activity

---

# Customer Lifetime Value Analysis

Analyze:

* Long-term customer profitability
* Loan renewal behavior
* Retention patterns

---

# Advanced Risk Scoring Engine

Develop a dynamic risk scoring model using:

* Repayment history
* Credit scores
* Transaction behavior
* Income patterns

---

# 16. Conclusion

The FinTech Loan Risk & Customer Analytics project demonstrates a complete end-to-end analytics workflow using SQL, Python, MySQL, Pandas, and Power BI.

The project successfully transforms raw financial datasets into actionable business intelligence through:

* Relational database design
* Advanced SQL analytics
* Python EDA
* Feature engineering
* KPI engineering
* Interactive Power BI dashboards
* Business insight generation

The final solution helps financial institutions:

* Identify high-risk customers
* Monitor repayment performance
* Improve lending visibility
* Analyze customer behavior
* Support data-driven lending decisions
* Improve portfolio monitoring and risk management

This project demonstrates practical analytics, business intelligence, and data storytelling skills used in real-world financial analytics environments.

# Key Business Insights
# Executive Insights

## 1. Active Loans Dominate the Lending Portfolio

The majority of loans remained active across the portfolio, indicating strong customer participation and continued lending activity within the financial institution.

---

## 2. Missed Payment Rates Remain Moderately High

A considerable percentage of customers showed missed or delayed repayments, highlighting potential repayment risk and the need for stronger repayment monitoring strategies.

---

## 3. High-Risk Customers Are Concentrated in Certain Employment Groups

Customers belonging to specific employment categories demonstrated higher repayment risk and increased missed payment frequency, making employment type an important risk indicator.

---

## 4. Middle-Income Salaried Customers Form the Largest Customer Segment

Middle-income salaried customers represented the largest portion of the lending portfolio, suggesting greater lending stability and lower default exposure within this segment.

---

## 5. Repayment Behavior Varies Across Income Categories

Customers from lower-income groups showed higher repayment delays and missed payments compared to middle- and high-income customers, indicating income level strongly impacts repayment reliability.

---

## 6. Repayment Trends Provide Early Risk Signals

Customers with repeated missed repayments and delayed payment patterns were more likely to fall into high-risk categories, making repayment behavior an effective early warning indicator.

---

## 7. Certain States Show Higher Risk Exposure

Some states demonstrated higher concentrations of high-risk customers and repayment issues, helping identify geographical regions requiring stricter lending policies.

---

## 8. Customer Transaction Activity Correlates With Financial Stability

Customers with healthier transaction activity and spending patterns generally showed better repayment consistency and lower financial risk exposure.

---

## 9. Loan Portfolio Monitoring Improves Lending Visibility

The interactive Power BI dashboards improved visibility into:

* Loan performance
* Repayment status
* Customer segmentation
* Portfolio risk
* Operational KPIs

This supports faster and more informed business decision-making.

---

## 10. Data-Driven Analytics Enhances Financial Decision-Making

The integration of SQL, Python, and Power BI enabled the creation of a scalable business intelligence workflow capable of improving:

* Risk management
* Customer monitoring
* Lending strategies
* Portfolio analysis
* Executive reporting
