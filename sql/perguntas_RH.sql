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

#Funcionários que fazem hora extra pedem mais demissão? 
SELECT
    overtime AS faz_hora_extra,
    COUNT(*) AS total_funcionarios,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS desligados,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS turnover_percentual
FROM rh
GROUP BY overtime
ORDER BY turnover_percentual DESC;

#Funcionários com baixa satisfação deixam mais a empresa? 
SELECT
	CASE 
		WHEN r.EnvironmentSatisfaction = 1 THEN 'Baixo(a)'
		WHEN r.EnvironmentSatisfaction = 2 THEN 'Médio(a)'
		WHEN r.EnvironmentSatisfaction = 3 THEN 'Alto(a)'
		ELSE 'Muito Alto(a)'
	END AS satisfacao,
    COUNT(*) AS total_funcionarios,
    SUM(CASE WHEN r.Attrition = 'Yes' THEN 1 ELSE 0 END) AS desligados,
    ROUND(SUM(CASE WHEN r.Attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS taxa_turnover
FROM rh r 
GROUP BY r.EnvironmentSatisfaction
ORDER BY taxa_turnover DESC;

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
 
#Qual departamento tem o maior custo salarial? 
SELECT 
	r.Department,
    SUM(r.MonthlyIncome) AS Custo_salarial
FROM rh r
GROUP BY r.Department
LIMIT 1;
 
#Funcionários solteiros saem mais? 
SELECT
	MaritalStatus AS estado_civil,
    COUNT(*) as qtd_funcionarios,
    SUM(CASE WHEN r.Attrition = 'No' THEN 1 ELSE 0 END) AS ativos,
    SUM(CASE WHEN r.Attrition = 'Yes' THEN 1 ELSE 0 END) AS desligados,
    ROUND(SUM(CASE WHEN r.Attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS taxa_turnover
FROM rh r
GROUP BY estado_civil
ORDER BY taxa_turnover DESC;

#Funcionários que viajam frequentemente deixam mais a empresa? 
SELECT
	CASE 
		WHEN BusinessTravel = 'Travel_Rarely' THEN 'Viaja Raramente'
        WHEN BusinessTravel = 'Travel_Frequently' THEN 'Viaja Frequentemente'
        WHEN BusinessTravel = 'Non-Travel' THEN 'Não Viaja'
    END AS frequencia_de_viagens,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS taxa_turnover
FROM rh
GROUP BY frequencia_de_viagens
ORDER BY taxa_turnover DESC;

#Existe relação entre Work-Life Balance e desligamento? 
SELECT
    CASE
        WHEN worklifebalance = 1 THEN 'Ruim'
        WHEN worklifebalance = 2 THEN 'Bom'
        WHEN worklifebalance = 3 THEN 'Melhor'
        WHEN worklifebalance = 4 THEN 'Excelente'
    END AS work_life_balance,
    COUNT(*) AS total_funcionarios,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS desligados,
    SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) AS ativos,
    ROUND(SUM(CASE  WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS taxa_turnover
FROM rh
GROUP BY worklifebalance
ORDER BY taxa_turnover DESC;
 

#Quais departamentos têm funcionários mais antigos? 
SELECT
    department,
    COUNT(*) AS total_funcionarios,
    ROUND(AVG(yearsatcompany), 2) AS tempo_medio_empresa
FROM rh
GROUP BY department
ORDER BY tempo_medio_empresa DESC;
 
#Quem ganha mais? 
SELECT
    jobrole,
    department,
    monthlyincome
FROM rh
ORDER BY monthlyincome DESC
LIMIT 10;

#Ranking dos cargos por salário médio. 
SELECT
	RANK() OVER (ORDER BY AVG(r.monthlyincome) DESC) AS RANKING,
	r.JobRole AS cargo,
    ROUND(AVG(r.monthlyincome), 2) AS salario_medio
FROM rh r
GROUP BY cargo;

