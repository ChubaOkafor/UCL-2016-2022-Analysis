create database football;

use football

select * from dbo.goals$;
select * from dbo.managers$
select * from dbo.matches$
select * from dbo.players$
select * from dbo.stadiums$
select * from dbo.teams$

select distinct team from dbo.managers$

delete from dbo.players$ 
where POSITION = 'fitness' or POSITION = 'arabia' or POSITION = 'emirates' or POSITION = 'rica' or POSITION = 'Republic'

-- Number of teams per country
select country, count(*) as Team_Count from dbo.teams$
group by country
order by Team_Count desc;

-- Largest stadiums by capacity
select name, CAPACITY from dbo.stadiums$
group by name, CAPACITY
order by CAPACITY desc;

-- Number of players by nationality
select top 5 NATIONALITY, count(*) as Player_Count from dbo.players$
where JERSEY_NUMBER is not null and AGE < 43 
group by NATIONALITY
order by Player_Count desc;

-- Number of players by team
select TEAM, count(*) as Player_Count from dbo.players$
where TEAM is not null and JERSEY_NUMBER is not null and age < 43 
group by TEAM
order by Player_Count desc;

-- Number of players by stronger foot
select FOOT, count(*) as Player_Count from dbo.players$
where FOOT is not null and JERSEY_NUMBER is not null and age < 43 
group by FOOT
order by Player_Count desc;

-- Age range of players in general and by position and country
alter table dbo.players$
alter column DOB date
go
-- Add age column
alter table dbo.players$ add AGE int


update dbo.players$
set AGE = DATEDIFF( YEAR, DOB, getdate())

select max(age) as oldest, min(age) as youngest from dbo.players$
where JERSEY_NUMBER is not null and age < 43 and POSITION != 'fitness'

-- General Age range
select case
when age >= 17 and age <= 25 then '17-25'
when age >= 26 and age <= 34 then '26-34'
when age >= 35 and age <= 43 then '35-43'
else '44+'
end as age_group,
COUNT(*) as Player_Count
from dbo.players$
where JERSEY_NUMBER is not null and age < 43 
group by case
when age >= 17 and age <= 25 then '17-25'
when age >= 26 and age <= 34 then '26-34'
when age >= 35 and age <= 43 then '35-43'
else '44+'
end
order by case
when age >= 17 and age <= 25 then '17-25'
when age >= 26 and age <= 34 then '26-34'
when age >= 35 and age <= 43 then '35-43'
else '44+'
end

-- Age Range by position 
select position, Young_17_25, Middle_Aged_26_34, Veteran_35_43, Young_17_25+Middle_Aged_26_34+Veteran_35_43 as Total_Players from 
(select POSITION, count(case when age >= 17 and age <= 25 then 1 end ) as Young_17_25,
count(case when age >= 26 and age <= 34 then 1 end ) as Middle_Aged_26_34,
count(case when age >= 35 and age <= 43 then 1 end ) as Veteran_35_43
from dbo.players$
where JERSEY_NUMBER is not null and age < 43 
group by position
) as subquery
order by Total_Players desc;

-- Average age by team
alter table dbo.players$
alter column age float

select top 5 team, round(AVG(age),1) as Average_Age from dbo.players$
group by team
order by Average_Age

-- Age Range by nationality
select nationality, Young_17_25, Middle_Aged_26_34, Veteran_35_43, Young_17_25 + Middle_Aged_26_34 + Veteran_35_43 as Total_Players from 
(select NATIONALITY, count(case when age >= 17 and age <= 25 then 1 end ) as Young_17_25,
count(case when age >= 26 and age <= 34 then 1 end ) as Middle_Aged_26_34,
count(case when age >= 35 and age <= 43 then 1 end ) as Veteran_35_43
from dbo.players$
where JERSEY_NUMBER is not null and age < 43 
group by NATIONALITY
) as subquery
order by Total_Players desc;

--- Average height and weight of players by position
-- Average height by position
select position, round(avg(height),2) as Average_Height from dbo.players$
where JERSEY_NUMBER is not null and age < 43 
group by position
order by Average_Height desc;

-- Average weight by position
select position, round(avg(WEIGHT),2) as Average_Weight from dbo.players$
where JERSEY_NUMBER is not null and age < 43 
group by position
order by Average_Weight desc;

-- Number of managers by country
alter table dbo.managers$
alter column DOB date
go

select nationality, count(*) as Manager_Count from dbo.managers$
group by NATIONALITY
order by Manager_Count desc;

--- Age range of managers
-- Add age column to table
alter table dbo.managers$ add AGE int

update dbo.managers$
set AGE = DATEDIFF( YEAR, DOB, getdate())

select max(age) as oldest, min(age) as youngest from dbo.managers$

--Age range
select case
when age >= 35 and age <= 45 then '35-45'
when age >= 46 and age <= 56 then '46-56'
when age >= 57 and age <= 67 then '57-67'
when age >= 68 and age <= 78 then '68-78'
else '79+'
end as age_group,
COUNT(*) as Manager_Count
from dbo.managers$
group by case
when age >= 35 and age <= 45 then '35-45'
when age >= 46 and age <= 56 then '46-56'
when age >= 57 and age <= 67 then '57-67'
when age >= 68 and age <= 78 then '68-78'
else '79+'
end
order by case
when age >= 35 and age <= 45 then '35-45'
when age >= 46 and age <= 56 then '46-56'
when age >= 57 and age <= 67 then '57-67'
when age >= 68 and age <= 78 then '68-78'
else '79+'
end

-- Average attendance of matches by stadium
select stadium, round(avg(attendance),0) as Average_Attendance from dbo.matches$
where ATTENDANCE != 0
group by STADIUM
order by Average_Attendance desc

----- Win Record per team
create table #WinLossRecord (Team_Name nvarchar (255), Result nvarchar (20))
Insert into #WinLossRecord
select HOME_TEAM as Team_Name, (case when Home_team_score > Away_team_score then 'W' when Home_team_score < Away_team_score then 'L'else 'D'end) 
as Result from dbo.matches$ 
union all
select away_team as Team_Name,(case when Away_team_score > Home_team_score then 'W' when Away_team_score < Home_team_score then 'L' else 'D'end) 
as Result from dbo.matches$;

create table #ChampsRecord (Team_Name nvarchar (255), Wins float, Draws Float, Losses float, Total_Games float)
Insert into #ChampsRecord
select Team_Name, Wins, Draws, Losses, Wins + Draws + Losses as Total_Games  from
(select Team_Name, count(case when result = 'W' then 1 end) as Wins,
count(case when result = 'D' then 1 end) as Draws,
count(case when result = 'L' then 1 end) as Losses
from #WinLossRecord
group by Team_Name) as subquery 
order by Total_Games desc

-- Record by number of matches
select top 5 * from #ChampsRecord
order by Total_Games desc

-- Record by percentage
select Team_Name, round((Wins/Total_Games),3) * 100 as Win_Pct, 
round((Draws/Total_Games),3) * 100 as Draw_Pct, 
round((Losses/Total_Games),3) * 100 as Loss_Pct, Total_Games from #ChampsRecord
order by Total_Games desc 

-- Stadium Occupancy Rate
select top 5 stadium, Average_attendance, capacity, round((Average_attendance/capacity)*100,2) as Occupancy_Rate
from (select mat.stadium as stadium, round(avg(mat.attendance),0) as Average_attendance, stad.capacity as capacity
from dbo.matches$  mat
join dbo.stadiums$ stad
on mat.STADIUM = stad.NAME
group by mat.STADIUM, stad.CAPACITY) as subquery
where Average_attendance != 0 and Average_attendance < capacity
order by Average_attendance desc

-- Stadiums with the most goals
alter table dbo.matches$ add Total_Goals float

update dbo.matches$
set Total_Goals = home_team_score + away_team_score

select stadium, Number_of_games, Total_Goals, round((Total_Goals/Number_of_games),2) as Goals_per_game from
(select stadium, count(*) as Number_of_Games, sum(Total_Goals) as Total_Goals from dbo.matches$
group by STADIUM) as subquery
order by Total_Goals desc

-- Top goal scorers
alter table dbo.players$ add Full_Name nvarchar(255)

update dbo.players$
set Full_Name = FIRST_NAME + ' ' + LAST_NAME

update dbo.players$
set Full_Name = Last_Name
where FIRST_NAME is null

select top 5  Player_ID, Full_Name, Age, Position, Number_of_Goals
from (select goal.PID as Player_ID, play.Full_Name as Full_Name, play.age as Age, play.POSITION as Position, count(*) as Number_of_Goals 
from dbo.players$ play
join dbo.goals$ goal
on play.PLAYER_ID = goal.PID
where goal.PID is not null
group by goal.PID, play.Full_Name, play.age, play.POSITION) as subquery
order by Number_of_Goals desc

-- Top 5 assisters
select top 5 Player_ID, Full_Name, Age, Position, Number_of_Assists
from (select goal.ASSIST as Player_ID, play.Full_Name as Full_Name, play.age as Age, play.POSITION as Position, count(*) as Number_of_Assists 
from dbo.players$ play
join dbo.goals$ goal
on play.PLAYER_ID = goal.ASSIST
where goal.ASSIST is not null
group by goal.ASSIST, play.Full_Name, play.age, play.POSITION) as subquery
order by Number_of_Assists desc

-- Goal distribution per half
select min(duration) as earliest, max(duration) as latest from dbo.goals$

select case
when duration >= 0 and DURATION <= 44 then 'First Half'
when DURATION >= 45 and DURATION <= 89 then 'Second Half'
when DURATION >= 90 and DURATION <= 104 then 'Extra time First Half'
else 'Extra time Second Half'
end as Half_Name,
COUNT(*) as Goal_Count
from dbo.goals$
where DURATION is not null 
group by case
when duration >= 0 and DURATION <= 44 then 'First Half'
when DURATION >= 45 and DURATION <= 89 then 'Second Half'
when DURATION >= 90 and DURATION <= 104 then 'Extra time First Half'
else 'Extra time Second Half'
end
order by Goal_Count desc

-- Top 5 scoring team
select top 5 Team, Number_of_Goals
from (select play.TEAM as Team, count(*) as Number_of_Goals 
from dbo.players$ play 
join dbo.goals$ goal
on play.PLAYER_ID = goal.PID
where goal.PID is not null and Team is not null
group by play.Team) as subquery
order by Number_of_Goals desc


-- Goals per game per season
select season, Number_of_Games, Goal_Count, round((Goal_Count/Number_of_Games),2) as Goals_Per_Game from
(select season, count(*) as Number_of_Games, sum(Total_Goals) as Goal_Count from dbo.matches$
group by season) as subquery
order by Goal_Count desc

-- Goal description count
select goal_desc, count(*) as Goal_Count from dbo.goals$
group by GOAL_DESC
order by Goal_Count desc