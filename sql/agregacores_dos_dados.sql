#Turnover por departamento 
WITH turnover_departamento AS (
    SELECT
        department,
        COUNT(*) AS total_funcionarios,
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS desligados
    FROM rh
    GROUP BY department
)
SELECT
    department,
    total_funcionarios,
    desligados,
    ROUND(desligados * 100.0 / total_funcionarios, 2) AS turnover_percentual
FROM turnover_departamento
ORDER BY turnover_percentual DESC;

#Turnover por cargo 
WITH turnover_cargo AS (
	SELECT
		r.jobrole as cargo,
        COUNT(*) AS total_funcionarios,
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS desligados
    FROM rh r
    GROUP BY r.jobrole
)
SELECT 
	cargo,
    total_funcionarios,
    desligados,
    ROUND(desligados * 100 / total_funcionarios, 2) AS turnover_percentual
FROM turnover_cargo
ORDER BY turnover_percentual DESC;

#Turnover por gênero 
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

#Salário médio por departamento 
SELECT
	Department as departamento,
	AVG(MonthlyIncome) as salario_medio
FROM rh
GROUP BY Department
ORDER BY salario_medio DESC;

#Salário médio por cargo 
SELECT
	JobRole as cargo,
	AVG(MonthlyIncome) as salario_medio
FROM rh
GROUP BY JobRole
ORDER BY salario_medio DESC;

#Média de anos na empresa por departamento 
SELECT
	Department as departamento,
	ROUND(AVG(YearsAtCompany), 2) as media_ano_empresa
FROM rh
GROUP BY Department
ORDER BY media_ano_empresa DESC;

#Média de idade por cargo 
SELECT
	JobRole as cargo,
    ROUND(AVG(Age), 2) AS media_idade
FROM rh
GROUP BY cargo
ORDER BY media_idade DESC;



