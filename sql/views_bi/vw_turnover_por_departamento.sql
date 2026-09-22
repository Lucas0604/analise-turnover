CREATE VIEW vw_turnover_por_departamento AS 
#Turnover por departamento 
WITH turnover_departamento AS (
    SELECT
        department,
        COUNT(*) AS total_funcionarios,
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS desligados
    FROM rh
    GROUP BY department
)
SELECT
    department,
    total_funcionarios,
    desligados,
    ROUND(desligados * 100.0 / total_funcionarios, 2) AS turnover_percentual
FROM turnover_departamento
ORDER BY turnover_percentual DESC;