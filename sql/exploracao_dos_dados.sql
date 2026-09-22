USE hr_ibm;
SELECT * FROM rh;

#Quantos funcionários existem?
SELECT 
	COUNT(*) AS total_funcionarios
FROM rh;

#Quantos funcionários ativos existem? 
SELECT COUNT(*)
FROM rh r
WHERE r.attrition = 'No';

#Quantos funcionários saíram da empresa? 
SELECT COUNT(*)
FROM rh r
WHERE r.attrition = 'Yes';

#Qual a taxa de turnover?
WITH total_funcionarios AS (
    SELECT COUNT(*) AS total
    FROM rh
),
funcionarios_desligados AS (
    SELECT COUNT(*) AS desligados
    FROM rh
    WHERE attrition = 'Yes'
)
SELECT
    ROUND((d.desligados * 100.0) / t.total, 2) AS taxa_turnover
FROM funcionarios_desligados d
CROSS JOIN total_funcionarios t;

#Quantos departamentos existem? 
SELECT
	COUNT(DISTINCT department)
FROM rh;

#Quantos cargos existem? 
SELECT
	COUNT(DISTINCT jobrole)
FROM rh;

#Qual o salário médio da empresa? 
SELECT
	AVG(r.monthlyincome) AS salario_medio
FROM rh r;

#Qual a idade média? 
SELECT 
	AVG(age) AS idade_media
FROM rh;

#Qual o tempo médio de empresa? 
SELECT 
	AVG(yearsatcompany) as tempo_medio_empresa
FROM rh;
