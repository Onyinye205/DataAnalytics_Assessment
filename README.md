# DataAnalytics_Assessment
Challenge Faced During the Assessment

I was unable to unzip the file containing the dataset, despite multiple attempts. To stay on track and time, I made logical assumptions about the table structures based on the task description and wrote SQL queries accordingly. While the queries may not perfectly match the actual dataset, this approach allowed me to demonstrate my understanding of SQL and data problem-solving. I’m happy to revise the work once I can access the real data.

Assessment_Q1 Explanation

To identify customers who have both a funded savings plan and a funded investment plan, sorted by total deposits, you’ll need to join and filter relevant tables. Let's use an SQL query that assumes:
	•	users_customuser contains customer details (e.g., id, name, etc.).
	•	savings_savingsaccount links customers to their savings plans and includes a deposit field and status (e.g., user_id, total_deposit, status).
	•	plans_plan contains investment plans and includes fields like user_id, plan_type (savings/investment), status, total_deposit.
 	•	Assumes status = 'funded' indicates a funded plan.
	•	I used SUM(COALESCE(...)) to handle potential nulls.
	•	HAVING ensures the user has at least one funded savings and investment plan.
	•	I replaced "name" with the actual column name for customer name in users_customuser.

Assessment_Q2 Explanation

1. Understanding the tables
We assume the minimal structures:
	•	users_customuser: contains customer data (id, created_at, etc.)
	•	savings_savingsaccount: contains savings transactions (id, user_id, transaction_date, etc.)

2. Aggregate Transaction Data
Calculate:
	•	Total number of transactions per customer
	•	Time span in months between first and last transaction (or use account creation date if available)
	•	Average transactions per month

3. Categorize Users by Frequency
Group users based on the average transactions per month and count users in each group.

  •	transaction_counts: aggregates total transactions and date range for each user.
	•	monthly_stats: computes how many months the user has been transacting and their average per month.
	•	categorized: assigns frequency buckets.
	•	Final SELECT: summarizes per frequency category.

 Assessment_Q3 Explanation

 To fulfill this task, we;
	1.	Identify active accounts from the plans_plan table of type Savings or Investments.
	2.	Join them with the savings_savingsaccount table to retrieve transaction history.
	3.	Filter out those with no inflow transactions in the past 365 days.
	4.	Calculate the last transaction date and the number of days since then (inactivity_days).
	5.	Output the required columns.

 Assessment_Q4 Explanation

 In this assessment, we need to calculate customer tenure, total transactions, and the estimated CLV using the simplified formula:
Estimated CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction with avg_profit_per_transaction = 0.001 * avg_transaction_value

Assumptions:
	Table users_customuser contains:
	•	id (primary key)
	•	name
	•	signup_date
	Table savings_savingsaccount contains:
	•	user_id (foreign key to users_customuser.id)
	•	transaction_value
	•	transaction_date

 Explanation
	•	AGE(CURRENT_DATE, u.signup_date) computes how long the user has had an account.
	•	DATE_PART('month', ...) extracts the number of months (account tenure).
	•	COUNT(s.id) counts the total number of transactions.
	•	AVG(s.transaction_value) gives the average transaction value per user.
	•	divide by NULLIF(..., 0) to avoid division by zero.
	•	ROUND(..., 2) formats the estimated CLV to 2 decimal places.
	•	Finally, i'll order the result by estimated_clv in descending order.
