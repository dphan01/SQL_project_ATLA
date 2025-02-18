# SQL project for Atlas Copco: Customer Sales &amp; Brand Analysis

This SQL project analyzes customer accounts across multiple Sales Organizations and Brands to uncover insights into account distribution and revenue trends. The dataset consists of three tables containing customer master data, sales organization mappings, and business area classifications. 

The provided datasets include dummy data provided by Atlas Copco. All queries were written on SQL Server Studio and therefore abided by this language dialect.

## Tasks:

### SQL - Task 1:

Customer ID (KUNNR) in KNA1 table is unique, however same customer can be present on multiple Sales Organizations (VKORG). We want to find these accounts and list all Sales organizations that are linked with them. Review the data in tables and create SQL query that will show following results:

- Only customers whose Sales Organizations are in “IT” Business area (Exclude accounts that are shared between IT and CT/PT business areas)
- Account group (KTOKD) is not “ZIGC”
- For each customer that is shared, show all sales organizations it belongs to, and group them in single line
- Count number of sales organizations for shared customer accounts
      
Present the results with following columns: CustomerNr, CustomerName, AccountGroup, SalesOrgs, SalesOrgCount.

Bonus: try ordering the sales organization alphabetically in the single line




### SQL - Task 2:

Customer ID can also be found on different Brands (SPART). We want to find all IT Business area accounts that belong to Brand “01” and at least one other Brand (02 – 05). Create a query that will show following results:

- Only customers whose Sales Organizations are in “IT” Business area (Exclude accounts that have another Brand, but belong to CT/PT business areas)
- Account group (KTOKD) is not “ZIGC”
- All customer accounts that belong to Brand 01 and another Brand (02 – 05)
- Sales organization given customer belongs under
      
Present the results with following columns: CustomerNr, CustomerName, SalesOrg, Brand, AccountGroup, SharedBrand.

Bonus: Group results by SalesOrg, SharedBrands and count the occurrences.




### SQL - Task 3:

Column ZDIFF in KNA1 represents difference in revenue from last year. Calculate average and median ZDIFF per each Account group (KTOKD). 
Present the results in same table with following columns, for example: AccountGroup, Average, Median
(In this part, the Business area doesn’t matter)


### Note on data –
- tblKNA1 contains unique Customer IDs (KUNNR)
- tblKNVV may contain Customer IDs extended to different SalesOrgs (VKORG) and Brand (SPART)
- tblENTRPR_STR contains unique SalesOrgs
