//=================================================================================

create or replace table "RONALDO"."PUBLIC"."DIM_SHOT_BASICS" (
    pkey integer not null,
    SHOT_BASICS_TYPE TEXT not null,
    constraint pkey primary key (pkey) not enforced
    );
   
insert into "RONALDO"."PUBLIC"."DIM_SHOT_BASICS"     
with cte1 as  (
select distinct SHOT_BASICS as SHOT_BASICS_TYPE from "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE"
)
select seq4()+1 as pkey,SHOT_BASICS_TYPE from cte1

select * from  "RONALDO"."PUBLIC"."DIM_SHOT_BASICS" 
//================================================================================================

create or replace table "RONALDO"."PUBLIC"."DIM_AREA_OF_SHOT" (
    pkey integer not null,
    AREA_OF_SHOT_TYPE TEXT not null,
    constraint pkey primary key (pkey) not enforced
    );
    
insert into "RONALDO"."PUBLIC"."DIM_AREA_OF_SHOT"     
with cte1 as  (
select distinct AREA_OF_SHOT as AREA_OF_SHOT_TYPE from "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE"
)
select seq4()+1 as pkey,AREA_OF_SHOT_TYPE from cte1

select * from  "RONALDO"."PUBLIC"."DIM_AREA_OF_SHOT" 
//================================================================================================