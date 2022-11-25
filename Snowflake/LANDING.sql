create or replace table "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE"  (
    SHOT_ID_NUMBER number not null,
    MATCH_ID number not null,
    DISTANCE_OF_SHOT number,
    POWER_OF_SHOT number,
    AREA_OF_SHOT number,
    SHOT_BASICS number,
    LOCATION_X float,
    LOCATION_Y float,
    REMAINING_MIN float,
    IS_GOAL number,
  constraint SHOT_ID_NUMBER primary key (SHOT_ID_NUMBER) not enforced,
  constraint MATCH_ID foreign key (MATCH_ID) references "RONALDO"."PUBLIC"."DIM_MATCH_INFO" (MATCH_ID) not enforced,
  constraint SHOT_BASICS foreign key (SHOT_BASICS) references "RONALDO"."PUBLIC"."DIM_SHOT_BASICS" (pkey) not enforced,
  constraint AREA_OF_SHOT foreign key (AREA_OF_SHOT) references "RONALDO"."PUBLIC"."DIM_AREA_OF_SHOT" (pkey) not enforced
    );
    
insert into "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE" 

with cte1 as (
select 
seq4()+1 as SHOT_ID_NUMBER,
MATCH_ID,
LOCATION_X,
LOCATION_Y,
POWER_OF_SHOT,
Coalesce(distance_of_shot,distance_of_shot_1) as DISTANCE_OF_SHOT,
IS_GOAL,
CASE
    WHEN AREA_OF_SHOT = 'Center(C)' THEN 1
    WHEN AREA_OF_SHOT = 'Right Side Center(RC)'THEN 2
    WHEN AREA_OF_SHOT = 'Right Side(R)'THEN 3
    WHEN AREA_OF_SHOT = 'Left Side Center(LC)'THEN 4
    WHEN AREA_OF_SHOT = 'Left Side(L)'THEN 5
    WHEN AREA_OF_SHOT = 'Mid Ground(MG)'THEN 6
    ELSE NULL
    END as AREA_OF_SHOT,
CASE
    WHEN SHOT_BASICS = 'Goal Line' THEN 1
    WHEN SHOT_BASICS = 'Penalty Spot'THEN 2
    WHEN SHOT_BASICS = 'Right Corner'THEN 3
    WHEN SHOT_BASICS = 'Goal Area'THEN 4
    WHEN SHOT_BASICS = 'Mid Range'THEN 5
    WHEN SHOT_BASICS = 'Left Corner'THEN 6
    WHEN SHOT_BASICS = 'Mid Ground Line'THEN 7
    ELSE NULL
    END as SHOT_BASICS,
Coalesce(remaining_min,remaining_min_1)+ (Coalesce(remaining_sec,remaining_sec_1)/60) as REMAINING_MIN
FROM
"RONALDO"."PUBLIC"."RONALDO_CAREER_STAGING_TABLE" where 
IS_GOAL is not null and 
SHOT_ID_NUMBER is not null and 
SHOT_ID_NUMBER > (select max(SHOT_ID_NUMBER) from "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE")
),

cte2 as(
select 
  mode(LOCATION_X) as mod_LOCATION_X,
  mode(LOCATION_Y) as mod_LOCATION_Y,
  mode(POWER_OF_SHOT) as mod_POWER_OF_SHOT,
  avg(DISTANCE_OF_SHOT) as avg_DISTANCE_OF_SHOT,
  mode(AREA_OF_SHOT) as mod_AREA_OF_SHOT,
  mode(SHOT_BASICS) as mod_SHOT_BASICS,
  avg(REMAINING_MIN) as avg_REMAINING_MIN 
  from cte1
  ),

cte3 as (
select 
  SHOT_ID_NUMBER,
  TO_NUMBER(MATCH_ID) as MATCH_ID,
  Coalesce(DISTANCE_OF_SHOT,avg_DISTANCE_OF_SHOT) as DISTANCE_OF_SHOT,
  TO_NUMBER(Coalesce(POWER_OF_SHOT,mod_POWER_OF_SHOT)) as POWER_OF_SHOT,
  Coalesce(AREA_OF_SHOT,mod_AREA_OF_SHOT) as AREA_OF_SHOT,
  Coalesce(SHOT_BASICS,mod_SHOT_BASICS) as SHOT_BASICS,
  Coalesce(LOCATION_X,mod_LOCATION_X) as LOCATION_X,
  Coalesce(LOCATION_Y,mod_LOCATION_Y) as LOCATION_Y,
  Coalesce(REMAINING_MIN,avg_REMAINING_MIN) as REMAINING_MIN,
  TO_NUMBER(IS_GOAL) as IS_GOAL
  from cte1 join cte2 on 1=1)

select * from cte3 ORDER BY SHOT_ID_NUMBER

Select * from "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE"