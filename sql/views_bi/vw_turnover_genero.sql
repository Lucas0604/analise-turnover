CREATE VIEW vw_turnover_genero AS
WITH turnover_genero AS (
	SELECT
		r.gender AS genero,
        COUNT(*) AS total_funcionarios,
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS desligados
    FROM rh r
    GROUP BY genero
)
SELECT
	genero,
    total_funcionarios,
    desligados,
    ROUND(desligados * 100 / total_funcionarios, 2) AS percentual_turnover
FROM turnover_genero tg
ORDER BY percentual_turnover DESC;