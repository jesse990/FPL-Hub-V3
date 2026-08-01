use fpl_fantasy
go
    
select 
	fixkey,
	gameweek,
	cast(home_code +season as int) as teamkey,
	'home' as home_away,
	away_code + season as opponent,
	date,
	away_diff as team_strength,
	home_diff as opp_strength,
	home_score as goals,
	away_score as opp_goals,
	season,
	home as teamname,
	away as oppname
from dim_fixture

union all

select
	fixkey,
	gameweek,
	cast(away_code + season as int) as teamkey,
	'away' as home_away,
	home_code + season as opponent,
	date,
	home_diff as team_strength,
	away_diff as opp_strength,
	away_score as goals,
	home_score as opp_goals,
	season,
	away as teamname,
	home as oppname
from dim_fixture
;

GO