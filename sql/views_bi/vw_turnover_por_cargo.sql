CREATE VIEW turnover_por_cargo AS
#Turnover por cargo 
WITH turnover_cargo AS (
	SELECT
		r.jobrole as cargo,
        COUNT(*) AS total_funcionarios,
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS desligados
    FROM rh r
    GROUP BY r.jobrole
)
SELECT 
	cargo,
    total_funcionarios,
    desligados,
    ROUND(desligados * 100 / total_funcionarios, 2) AS turnover_percentual
FROM turnover_cargo
ORDER BY turnover_percentual DESC;