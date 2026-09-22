CREATE VIEW vw_faixa_etaria AS
SELECT
	CASE
		WHEN Age < 25 THEN 'Até 24 anos'
		WHEN Age BETWEEN 25 AND 34 THEN '25-34 anos'
		WHEN Age BETWEEN 35 AND 44 THEN '35-44 anos'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54 anos'
		ELSE '55+ anos'
	END AS faixa_etaria,
	COUNT(*) AS quantidade
FROM rh
GROUP BY faixa_etaria
ORDER BY quantidade DESC;