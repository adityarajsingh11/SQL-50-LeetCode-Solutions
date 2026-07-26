-- Write your MySQL query statement below

SELECT Signups.user_id ,
       ROUND(AVG(IF(Confirmations.action = 'confirmed',1,0)),2) as confirmation_rate
From Signups
left Join Confirmations
On Signups.user_id = Confirmations.user_id
group by Signups.user_id;

