SELECT
    e.name,
    SUM(CASE WHEN a.kind='base'   THEN a.amount ELSE 0 END) AS оклад,
    SUM(CASE WHEN a.kind='bonus'  THEN a.amount ELSE 0 END) AS премия,
    SUM(CASE WHEN a.kind='vac'    THEN a.amount ELSE 0 END) AS отпускные,
    SUM(CASE WHEN a.kind='sick'   THEN a.amount ELSE 0 END) AS больничный,
    SUM(a.amount) AS начислено,
    SUM(a.amount) * 0.13 AS ндфл,
    SUM(a.amount) * 0.87 AS на_руки
FROM employees e
JOIN accruals a ON a.employee_id = e.id
WHERE a.period_id = $1
GROUP BY e.id;
