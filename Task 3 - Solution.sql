/*
SQL - Part 3:

Column ZDIFF in KNA1 represents difference in revenue from last year. 
Calculate average and median ZDIFF per each Account group (KTOKD). 
(In this part, the Business area doesn’t matter)
*/

WITH Median_CTE AS
(
	SELECT DISTINCT 
		KTOKD, 
		PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ZDIFF) OVER(PARTITION BY KTOKD) AS Median
	FROM ATLASCOPCO_TEST..tblKNA1
)
SELECT DISTINCT 
	t1.KTOKD AS AccountGroup,
	ROUND(AVG(ZDIFF), 2) AS Average, 
	ROUND(Median, 2) AS Median
FROM 
	ATLASCOPCO_TEST..tblKNA1 t1 
	JOIN Median_CTE t2 
	ON t1.KTOKD = t2.KTOKD
GROUP BY t1.KTOKD, Median 