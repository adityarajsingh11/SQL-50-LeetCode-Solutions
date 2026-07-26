-- Write your MySQL query statement below

SELECT ROUND(COUNT(DISTINCT Activity.player_id) /
    (SELECT COUNT(DISTINCT player_id)
    FROM Activity),
    2) AS fraction

FROM Activity

JOIN
(
    SELECT
        player_id,
        MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
) first_login

ON Activity.player_id = first_login.player_id
AND DATEDIFF(Activity.event_date, first_login.first_login) = 1;