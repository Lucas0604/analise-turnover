#Ranking salarial usando RANK() 
SELECT
    RANK() OVER (ORDER BY monthlyincome DESC) AS ranking,
    department,
    jobrole,
    monthlyincome
FROM rh
ORDER BY ranking;

#Ranking salarial usando DENSE_RANK() 
SELECT
    DENSE_RANK() OVER (ORDER BY AVG(monthlyincome) DESC) AS ranking,
    jobrole,
    ROUND(AVG(monthlyincome), 2) AS media_salarial
FROM rh
GROUP BY jobrole
ORDER BY ranking;

#Ranking dos funcionários mais antigos 
SELECT
    RANK() OVER (ORDER BY YearsAtCompany DESC) AS ranking,
    Department,
    JobRole,
    YearsAtCompany
FROM rh
ORDER BY ranking;

#Salário acima da média 
SELECT
	r.MonthlyIncome
FROM rh r
WHERE r.MonthlyIncome > (SELECT AVG(MonthlyIncome) FROM rh);

#Idade acima da média 
SELECT
	r.Age
FROM rh r
WHERE r.Age > (SELECT AVG(Age) FROM rh);

#Diferença entre salário do funcionário e média do departamento 
SELECT
    department,
    jobrole,
    monthlyincome,
    ROUND(AVG(monthlyincome) OVER (PARTITION BY department), 2) AS salario_medio_departamento,
    ROUND(monthlyincome - AVG(monthlyincome) OVER (PARTITION BY department), 2) AS diferenca_media
FROM rh
ORDER BY department, diferenca_media DESC;

#Percentual de turnover por departamento 
SELECT
	r.Department as departamento,
	ROUND(SUM(CASE WHEN r.Attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS turnover_percentual
FROM rh r
GROUP BY r.Department;

#Percentual acumulado de turnover 
WITH turnover_departamento AS (
    SELECT
        department,
        ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS turnover_percentual
    FROM rh
    GROUP BY department
)
SELECT
    department,
    turnover_percentual,
    ROUND(SUM(turnover_percentual) OVER (ORDER BY turnover_percentual DESC), 2) AS turnover_acumulado
FROM turnover_departamento
ORDER BY turnover_percentual DESC;


#Top 20% cargos com maior salário 
WITH salario_cargo AS (
    SELECT
        jobrole,
        ROUND(AVG(monthlyincome), 2) AS salario_medio
    FROM rh
    GROUP BY jobrole
)
SELECT
    jobrole,
    salario_medio,
    NTILE(5) OVER (ORDER BY salario_medio DESC) AS quintil
FROM salario_cargo
ORDER BY salario_medio DESC;


#Top 20% departamentos com maior turnover 

WITH turnover_departamento AS (
    SELECT
        department,
        ROUND(SUM(CASE WHEN attrition='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS turnover
    FROM rh
	GROUP BY department
),
ranking AS (
    SELECT
        department,
        turnover,
        NTILE(5) OVER (ORDER BY turnover DESC) AS quintil
    FROM turnover_departamento
)
SELECT *
FROM ranking
WHERE quintil = 1
ORDER BY turnover DESC;
