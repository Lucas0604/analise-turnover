CREATE VIEW vw_ranking_salarial_cargo AS
#Ranking salarial usando DENSE_RANK() 
SELECT
    DENSE_RANK() OVER (ORDER BY AVG(monthlyincome) DESC) AS ranking,
    jobrole,
    ROUND(AVG(monthlyincome), 2) AS media_salarial
FROM rh
GROUP BY jobrole
ORDER BY ranking;