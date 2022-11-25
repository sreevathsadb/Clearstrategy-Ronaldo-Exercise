with cte1 AS 
 (select IS_GOAL,count(IS_GOAL)  as  N from "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE" group by IS_GOAL)
 select IS_GOAL,n/sum(n) over() * 100 as percentage from cte1


with cte2 AS 
 (select SHOT_BASICS,count(IS_GOAL)  as  N from "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE" group by SHOT_BASICS)
 select SHOT_BASICS,n/sum(n) over() * 100 as percentage from cte2 order by n/sum(n) over() * 100 desc
 

with cte3 AS 
 (select HOME_AWAY,IS_GOAL,count(IS_GOAL)  as  N from "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE" group by HOME_AWAY,IS_GOAL)
 select HOME_AWAY,IS_GOAL,n/sum(n) over() * 100 as percentage from cte3 order by n/sum(n) over() * 100 desc
 

with cte4 AS 
 (select KNOCKOUT_MATCH,IS_GOAL,count(IS_GOAL)  as  N from "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE" group by KNOCKOUT_MATCH,IS_GOAL)
 select KNOCKOUT_MATCH,IS_GOAL,n/sum(n) over() * 100 as percentage from cte4 order by n/sum(n) over() * 100 desc
 
with cte5 AS 
 (select GAME_SEASON,count(IS_GOAL)  as  N from "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE" where IS_GOAL = 1 group by GAME_SEASON )
 select * from cte5 order by GAME_SEASON
 
with cte6 AS 
 (select OPPONENT,count(IS_GOAL)  as  N from "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE" where IS_GOAL = 1 and HOME_AWAY = 'HOME' group by OPPONENT )
 select * from cte6 order by N desc
 
with cte7 AS 
 (select OPPONENT,count(IS_GOAL)  as  N from "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE" where IS_GOAL = 1 and HOME_AWAY = 'HOME' group by OPPONENT )
 select * from cte7 order by N desc
 
with cte8 AS 
 (select POWER_OF_SHOT,count(IS_GOAL)  as  N from "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE" where IS_GOAL = 1 group by POWER_OF_SHOT)
 select POWER_OF_SHOT,n/sum(n) over() * 100 as percentage from cte8 order by n/sum(n) over() * 100 desc