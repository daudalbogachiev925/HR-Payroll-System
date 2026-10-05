-- НДФЛ: 13% до 5 млн, 15% свыше
WITH salaries AS (
    SELECT employee_id, SUM(amount) AS total
    FROM accruals WHERE period_id = $1
    GROUP BY employee_id
)
SELECT employee_id,
    total,
    CASE WHEN total <= 5000000 THEN total * 0.13
         ELSE 5000000 * 0.13 + (total - 5000000) * 0.15
    END AS ndfl
FROM salaries;
