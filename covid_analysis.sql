------- America is leading-----
SELECT  Region, sum(Confirmed) as total_confirmed, sum(deaths) as death, sum(Recovered) as rec, sum(active) as new
FROM pop.country
group by Region
order by death desc;


--- America most recovery---- 
SELECT  Region, sum(Confirmed) as total_confirmed, sum(deaths) as death, sum(Recovered) as rec, sum(active) as new
FROM pop.country
group by Region
order by rec desc;

------------ -  America-- 

with cte as(
SELECT  Region, sum(Confirmed) as total_confirmed, sum(deaths) as death, sum(Recovered) as recovered, sum(active) as new
FROM pop.country
group by Region
order by new desc), total_data as(
select *, round(death*100/total_confirmed,2) as death_percent , round(recovered*100/total_confirmed,2) as recover_percent
from cte)
select *
from total_data;


------------------ -                    ------------
CREATE   view top_eu
as  
select * 
from pop.country
where region = 'europe'
order by deaths desc;

select *
from top_eu;


DELIMITER //

CREATE PROCEDURE EU( )
BEGIN
    SELECT * 
    FROM pop.country
    WHERE region = 'europe'
    ORDER BY deaths DESC;
END  //

DELIMITER ;

CALL EU;

create view africa as
select *
from pop.country
where region = 'africa';

select *
from africa;

select *, sum(deaths) over(partition by region) as cum_sum 
from pop.country;
