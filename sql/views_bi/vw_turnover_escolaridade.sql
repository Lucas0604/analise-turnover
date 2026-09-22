CREATE VIEW vw_turnover_escolaridade AS
#Turnover por escolaridade 
WITH turnover_escolaridade AS (
	SELECT
		CASE
			WHEN Education = 1 THEN 'Ensino Médio'
            WHEN Education = 2 THEN 'Curso Técnico / Profissionalizante'
            WHEN Education = 3 THEN 'Graduação'
            WHEN Education = 4 THEN 'Pós-graduação / Mestrado'
            ELSE 'Doutorado'
		END AS escolaridade,
        Attrition
	FROM rh
)
SELECT
	escolaridade,
    COUNT(*) AS total_funcionario,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS desligados,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS percentual_turnover    
FROM turnover_escolaridade
GROUP BY escolaridade
ORDER BY percentual_turnover DESC;