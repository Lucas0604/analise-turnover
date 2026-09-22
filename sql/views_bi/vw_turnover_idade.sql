CREATE VIEW vw_turnover_idade AS
#Turnover por faixa etária 
WITH turnover_idade AS (
    SELECT
        CASE
            WHEN age < 25 THEN 'Até 24 anos'
            WHEN age BETWEEN 25 AND 34 THEN '25-34 anos'
            WHEN age BETWEEN 35 AND 44 THEN '35-44 anos'
            WHEN age BETWEEN 45 AND 54 THEN '45-54 anos'
            ELSE '55+ anos'
        END AS faixa_etaria,
        attrition
    FROM rh
)
SELECT
    faixa_etaria,
    COUNT(*) AS total_funcionarios,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS desligados,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS turnover_percentual
FROM turnover_idade
GROUP BY faixa_etaria
ORDER BY turnover_percentual DESC;