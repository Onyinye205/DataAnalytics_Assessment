WITH transaction_counts AS (
    SELECT 
        sa.user_id,
        COUNT(*) AS total_transactions,
        DATE_TRUNC('month', MIN(sa.transaction_date)) AS first_month,
        DATE_TRUNC('month', MAX(sa.transaction_date)) AS last_month
    FROM 
        savings_savingsaccount sa
    GROUP BY 
        sa.user_id
),

monthly_stats AS (
    SELECT 
        tc.user_id,
        tc.total_transactions,
        GREATEST(DATE_PART('month', AGE(tc.last_month, tc.first_month)) + 
                 (DATE_PART('year', AGE(tc.last_month, tc.first_month)) * 12), 1) AS months_active,
        ROUND(tc.total_transactions::numeric / 
              GREATEST(DATE_PART('month', AGE(tc.last_month, tc.first_month)) + 
                       (DATE_PART('year', AGE(tc.last_month, tc.first_month)) * 12), 1), 2) 
              AS avg_transactions_per_month
    FROM 
        transaction_counts tc
),

categorized AS (
    SELECT 
        CASE 
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month >= 3 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        user_id,
        avg_transactions_per_month
    FROM 
        monthly_stats
)

SELECT 
    frequency_category,
    COUNT(user_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM 
    categorized
GROUP BY 
    frequency_category
ORDER BY 
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        ELSE 3
    END;
