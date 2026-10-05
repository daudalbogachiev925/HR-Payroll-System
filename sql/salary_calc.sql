-- Расчёт ЗП за месяц
WITH hours AS (
    SELECT employee_id, SUM(hours) AS worked
    FROM timesheet
    WHERE period_id = $1 GROUP BY employee_id
),
base AS (
    SELECT e.id, e.name, p.base_salary,
           COALESCE(h.worked,0) AS worked
    FROM employees e
    JOIN positions p ON p.id = e.position_id
    LEFT JOIN hours h ON h.employee_id = e.id
)
SELECT
    id, name,
    base_salary,
    worked,
    ROUND(base_salary * worked / 168.0, 2) AS gross
FROM base;
