WITH last_inflow AS (
    SELECT
        s.plan_id,
        MAX(s.transaction_date) AS last_transaction_date
    FROM savings_savingsaccount s
    WHERE s.transaction_type = 'inflow'
    GROUP BY s.plan_id
),
inactive_accounts AS (
    SELECT
        p.plan_id,
        p.owner_id,
        p.type,
        l.last_transaction_date,
        DATE_PART('day', CURRENT_DATE - l.last_transaction_date) AS inactivity_days
    FROM plans_plan p
    LEFT JOIN last_inflow l ON p.plan_id = l.plan_id
    WHERE
        p.type IN ('Savings', 'Investments')
        AND (l.last_transaction_date IS NULL OR l.last_transaction_date < CURRENT_DATE - INTERVAL '365 days')
)

SELECT * FROM inactive_accounts;
