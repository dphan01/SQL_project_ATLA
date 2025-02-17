/*
SQL - Part 1 (breakdowns):

Customer ID (KUNNR) in KNA1 table is unique, however same customer can be present on multiple Sales Organizations (VKORG).
We want to find these accounts and list all Sales organizations that are linked with them. 
Review the data in tables and create SQL query that will show following results:

 #FIELDS: 
	CustomerNr = KUNNR (t1)
	Name = Name 1 (t1)
	AccountGroup = KTOKD (t1)
	SalesOrgs = VKORG (t2 x t3)
	SalesOrgsCount

 #CON1 (T3): Only customers whose Sales Organizations are in “IT” Business area 
(Exclude accounts that are shared between IT and CT/PT business areas)

 #CON2 (T1): Account group (KTOKD) is not “ZIGC”

 #CON3: For each customer thats shared, show all sales organizations it belongs to, and group them in single line

 #CON4: Count number of sales organizations for shared customer accounts

Bonus: try ordering the sales organization alphabetically in the single line
*/

SELECT DISTINCT
    CustomerNr, 
    Name, 
    AccountGroup, 
    STRING_AGG(SalesOrgs, ', ') WITHIN GROUP (ORDER BY SalesOrgs) AS SalesOrgs,
	COUNT(*) AS SalesOrgsCount
FROM 
(
	SELECT DISTINCT 
		t1.KUNNR AS CustomerNr, 
		t1.NAME1 AS Name, 
		t1.KTOKD AS AccountGroup, 
		t2.VKORG AS SalesOrgs
	 FROM 
		ATLASCOPCO_TEST..tblKNA1 AS t1 
		JOIN ATLASCOPCO_TEST..tblKNVV AS t2 
		ON t1.KUNNR = t2.KUNNR 
		JOIN ATLASCOPCO_TEST..tblENTRPR_STR AS t3
		ON t2.VKORG = t3.SALES_ORG
	WHERE 
		t3.BUSINESS_AREA = 'IT' 
		AND t1.KTOKD <> 'ZIGC'
) AS sub
GROUP BY CustomerNr, Name, AccountGroup
ORDER BY CustomerNr;
