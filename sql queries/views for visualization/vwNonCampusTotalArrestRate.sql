
CREATE VIEW `vwNonCampusTotalArrestRate` AS
SELECT        ID, SUM(WEAPON10 + DRUG10 + LIQUOR10 + WEAPON11 + DRUG11 + LIQUOR11 + WEAPON12 + DRUG12 + LIQUOR12) AS TotalArrests, SUM(Total) AS Total,
                         CASE WHEN SUM(Total) = 0 THEN 0 ELSE SUM(WEAPON10 + DRUG10 + LIQUOR10 + WEAPON11 + DRUG11 + LIQUOR11 + WEAPON12 + DRUG12 + LIQUOR12)
                         * 100000 / SUM(Total) END AS ArrestRate
FROM            rkhadse.NonCampusArrest
GROUP BY ID
