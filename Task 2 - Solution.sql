/*
SQL - Part 2 (breakdowns):

Customer ID can also be found on different Brands (SPART).
We want to find all IT Business area accounts that belong to Brand “01” and at least one other Brand (02 – 05).
Create a query that will show following results:

 #FIELDS: 
	CustomerNr = KUNNR (t1)
	Name = Name 1 (t1)
	SalesOrgs = VKORG (t2 x t3)
	Brand = SPART (t2)
	AccountGroup = KTOKD (t1)
	SharedBrand = SPART (t2)

 #CON1: Only customers whose Sales Organizations are in “IT” Business area
(Exclude accounts that have another Brand, but belong to CT/PT business areas)

 #CON2: Account group (KTOKD) is not “ZIGC”

 #CON3: All customer accounts that belong to Brand 01 and another Brand (02 – 05)

 #CON4: Sales organization given customer belongs under
*/
WITH OtherBrands AS
(
	SELECT DISTINCT KUNNR
	FROM ATLASCOPCO_TEST..tblKNVV
	WHERE SPART <> '01'
)
SELECT DISTINCT 
	t1.KUNNR AS CustomerNr, 
	t1.NAME1 AS Name, 
	t2.VKORG AS SalesOrg, 
	'01' AS  Brand, 
	t1.KTOKD AS AccountGroup, 
	t2.SPART AS SharedBrand
FROM 
	ATLASCOPCO_TEST..tblKNA1 AS t1 
	JOIN ATLASCOPCO_TEST..tblKNVV AS t2
	ON t1.KUNNR = t2.KUNNR
	JOIN ATLASCOPCO_TEST..tblENTRPR_STR AS t3
	ON t2.VKORG = t3.SALES_ORG
WHERE t1.KUNNR IN (
	SELECT DISTINCT KUNNR
	FROM ATLASCOPCO_TEST..tblKNVV
	WHERE SPART = '01')
	AND t1.KUNNR IN (SELECT DISTINCT KUNNR FROM OtherBrands)
	AND t2.SPART <> '01'
	AND t3.BUSINESS_AREA = 'IT'
	AND t1.KTOKD <> 'ZIGC'
;

/*
Bonus: Group results by SalesOrg, SharedBrands and count the occurrences
*/
WITH OtherBrands AS
(
	SELECT DISTINCT KUNNR
	FROM ATLASCOPCO_TEST..tblKNVV
	WHERE SPART <> '01'
),
MainQuery AS 
(
	SELECT DISTINCT 
		t1.KUNNR AS CustomerNr, 
		t1.NAME1 AS Name, 
		t2.VKORG AS SalesOrg, 
		'01' AS  Brand, 
		t1.KTOKD AS AccountGroup, 
		t2.SPART AS SharedBrand
	FROM 
		ATLASCOPCO_TEST..tblKNA1 AS t1 
		JOIN ATLASCOPCO_TEST..tblKNVV AS t2
		ON t1.KUNNR = t2.KUNNR
		JOIN ATLASCOPCO_TEST..tblENTRPR_STR AS t3
		ON t2.VKORG = t3.SALES_ORG
	WHERE t1.KUNNR IN (
		SELECT DISTINCT KUNNR
		FROM ATLASCOPCO_TEST..tblKNVV
		WHERE SPART = '01')
		AND t1.KUNNR IN (SELECT DISTINCT KUNNR FROM OtherBrands)
		AND t2.SPART <> '01'
		AND t3.BUSINESS_AREA = 'IT'
		AND t1.KTOKD <> 'ZIGC'
)
SELECT DISTINCT 
	SalesOrg,
	SharedBrand,
	COUNT(*) AS SharedBrandsCount
FROM MainQuery
GROUP BY SalesOrg, SharedBrand
ORDER BY SharedBrandsCount DESC, SalesOrg;