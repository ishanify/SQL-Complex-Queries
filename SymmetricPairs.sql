/* 
Approach:
1. Inner select statement selects those rows which are symmetric. This includes mirror images for example (2,24), (24,2), (3,13) and (13,3).
BUT ideally a pair should only appear once (2,24) and (3,13) etc. in this case.
In this sub query the rows with X=Y are also ignored and these rows are taken care of in step 3; because there should be atleast 2 rows for same X,Y where X=Y otherwise it's not symmetric..

2. DISTINCT is used to resolve this issue and to get distinct pairs in cases where there is cross duplication.

3. UNION is used to get those symmetric pairs where X=Y. There should be atleast 2 rows with same (X,Y) pair.

*/

SELECT DISTINCT
    CASE WHEN nx>ny THEN ny ELSE nx END c1,
    CASE WHEN nx>ny THEN nx ELSE ny END c2
FROM 
    (SELECT f1.X as nx, f1.Y as ny FROM Functions f1, Functions f2
    WHERE f1.X=f2.Y AND f1.Y=f2.X AND f1.X<>f1.Y) sub
UNION
SELECT X,Y FROM Functions
    WHERE X=Y
    GROUP BY X,Y
    HAVING COUNT(X)>1
ORDER BY c1;
