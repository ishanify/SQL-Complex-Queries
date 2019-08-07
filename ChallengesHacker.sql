SELECT Hackers.hacker_id, Hackers.name, sub3.fin_cnt
FROM
Hackers
INNER JOIN /* This join is to connect name with Hacker ID only*/
    (SELECT sub1.hacker_id as hid, MAX(sub1.cnt) as fin_cnt
    FROM 
        (SELECT hacker_id, COUNT(challenge_id) cnt
        FROM Challenges
        GROUP BY hacker_id) sub1
    
     /*self join to fulfill the conditions of getting hacker_ids with same number of submissions AND less than MAX submissions*/
     INNER JOIN 
        (SELECT hacker_id, COUNT(challenge_id) cnt
        FROM Challenges
        GROUP BY hacker_id) sub2
    ON sub1.cnt=sub2.cnt
    GROUP BY sub1.hacker_id
    HAVING COUNT(sub1.cnt)=1 
        OR MAX(sub1.cnt)= (SELECT COUNT(challenge_id) AS max_sub
                            FROM Challenges
                            GROUP BY hacker_id
                            ORDER BY max_sub DESC 
                            LIMIT 1)
        ) sub3
ON sub3.hid=Hackers.hacker_id
ORDER BY sub3.fin_cnt DESC, Hackers.hacker_id 
