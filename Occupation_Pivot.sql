/*
Approach
1. Explore the Occupations table on the HackerRank link.

2. Create a TEMP table using CASE statements; with  row numbers as a new column and Name as per Occupations. For better understanding check TEMP table before grouping

3. To remove the NULLS Group by row numbers assigned in Step 1

*/

/* ROW NUMBERS */
SET @r1 =0, @r2=0,@r3=0,@r4=0;

SELECT min(d), min(p), min(s), min(a)
FROM(
/* TEMP table - first column of row numbers*/
SELECT 
(CASE 
    WHEN OCCUPATION = 'Doctor' THEN (@r1:=@r1+1)
    WHEN OCCUPATION = 'Professor' THEN (@r2:=@r2+1)
    WHEN OCCUPATION = 'Singer' THEN (@r3:=@r3+1)
    WHEN OCCUPATION = 'Actor'  THEN (@r4:=@r4+1)
    END) as rownums
,
    
/* Different CASE Statements for different columns */
(CASE WHEN OCCUPATION = 'Doctor' THEN NAME
    ELSE NULL END) as d,
    
(CASE WHEN OCCUPATION = 'Professor' THEN NAME
    ELSE NULL END) as p,
    
(CASE WHEN OCCUPATION = 'Singer' THEN NAME
    ELSE NULL END) as s,
    
(CASE WHEN OCCUPATION = 'Actor' THEN NAME
    ELSE NULL END) as a

FROM OCCUPATIONS
ORDER BY Name
) temp

GROUP BY rownums
;
