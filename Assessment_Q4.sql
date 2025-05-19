SELECT 
    u.id AS customer_id,
    u.name,
    DATE_PART('month', AGE(CURRENT_DATE, u.signup_date)) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    ROUND(
        (
            COUNT(s.id)::decimal / NULLIF(DATE_PART('month', AGE(CURRENT_DATE, u.signup_date)), 0)
        ) * 12 * 0.001 * AVG(s.transaction_value), 2
    ) AS estimated_clv
FROM 
    users_customuser u
JOIN 
    savings_savingsaccount s ON u.id = s.user_id
GROUP BY 
    u.id, u.name, u.signup_date
ORDER BY 
    estimated_clv DESC;
