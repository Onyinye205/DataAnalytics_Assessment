SELECT 
    u.id AS owner_id,
    u.name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT p.id) AS investment_count,
    SUM(COALESCE(s.total_deposit, 0) + COALESCE(p.total_deposit, 0)) AS total_deposits
FROM 
    users_customuser u
JOIN 
    savings_savingsaccount s ON s.user_id = u.id AND s.status = 'funded'
JOIN 
    plans_plan p ON p.user_id = u.id AND p.status = 'funded' AND p.plan_type = 'investment'
GROUP BY 
    u.id, u.name
HAVING 
    COUNT(DISTINCT s.id) >= 1 AND COUNT(DISTINCT p.id) >= 1
ORDER BY 
    total_deposits DESC;
