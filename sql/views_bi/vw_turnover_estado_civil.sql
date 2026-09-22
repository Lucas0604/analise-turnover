CREATE VIEW turnover_estado_civil AS 
#Turnover por estado civil 
WITH turnover_estado_civil AS (
	SELECT
		r.MaritalStatus AS Estado_civil,
        COUNT(*) AS total_funcionarios,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS desligados
    FROM rh r
    GROUP BY Estado_civil
)
SELECT
	Estado_civil,
    total_funcionarios,
    desligados,
    ROUND(desligados * 100 / total_funcionarios, 2) AS percentual_turnover
FROM turnover_estado_civil
ORDER BY percentual_turnover DESC;