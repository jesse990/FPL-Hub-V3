go
create or alter view v_fixtures as 
select
	try_cast(code as int) as optacode,
	try_cast(event as int) as event,
	id ,
	team_a,
	team_h,
	try_cast(team_a_score as int) as away_score,
	try_cast(team_h_score as int) as home_score,
	try_cast(team_a_difficulty as int) as away_diff,
	try_cast(team_h_difficulty as int) as home_diff,
	season,
	kickoff_time,
	finished
from fpl_fantasy.dbo.stg_fixtures


