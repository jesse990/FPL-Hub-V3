go
create or alter view v_player_scores as
select 
	player_code as code,
	try_cast(gameweek as int) as gw,
	try_cast(minutes as int) as minutes,
	try_cast(fixture_id as int) as fixture_id,
	try_cast(mins_score as decimal(10,2)) as mins_score,
	try_cast(goals_score as decimal(10,2)) as goals_score,
	try_cast(assists_score as decimal(10,2)) as assists_score,
	try_cast(xg_score as decimal(10,2)) as xg_score,
	try_cast(xgi_score as decimal(10,2)) as xgi_score,
	try_cast(cs_score as decimal(10,2)) as cs_score,
	try_cast(bonus_score as decimal(10,2)) as bonus_score,
	try_cast(goals_conceded_score as decimal(10,2)) as gc_score,
	try_cast(xgc_score as decimal(10,2)) as xgc_score,
	try_cast(composite_score as decimal(10,2)) as final_score,
	season
from stg_player_scores