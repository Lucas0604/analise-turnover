CREATE VIEW vw_cargo_com_mais_desligamento AS 
#Quais cargos possuem maior índice de desligamento? 
SELECT
	r.JobRole AS cargo,
    COUNT(*) AS tot_funcionarios,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS desligados,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS indice_desligamento
FROM rh r
GROUP BY cargo
ORDER BY indice_desligamento DESC
LIMIT 4;