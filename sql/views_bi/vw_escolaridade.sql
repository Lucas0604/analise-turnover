CREATE VIEW vw_escolaridade AS
SELECT
	rh.EducationField as escolaridade,
    COUNT(*) AS funcionarios
FROM rh 
GROUP BY rh.EducationField
ORDER BY funcionarios DESC;