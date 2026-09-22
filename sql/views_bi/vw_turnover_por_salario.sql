CREATE VIEW vw_turnover_por_salario AS
#Existe relação entre salário e turnover? 
SELECT
	CASE
		WHEN monthlyincome < 3000 THEN 'Até R$ 3.000'
		WHEN monthlyincome BETWEEN 3000 AND 5999 THEN 'R$ 3.000 - R$ 5.999'
		WHEN monthlyincome BETWEEN 6000 AND 9999 THEN 'R$ 6.000 - R$ 9.999'
		WHEN monthlyincome BETWEEN 10000 AND 14999 THEN 'R$ 10.000 - R$ 14.999'
		ELSE 'R$ 15.000 ou mais'
	END AS faixa_salarial,
    ROUND(SUM(CASE WHEN r.Attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS turnover_percentual
FROM rh r
GROUP BY faixa_salarial
ORDER BY turnover_percentual DESC;