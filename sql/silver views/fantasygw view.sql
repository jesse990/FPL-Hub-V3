go
create or alter view dbo.v_fantasy_gw as
select
	try_cast(gameweek_id as int) as gw,
	try_cast(average_score as int) as average_score,
	try_cast(highest_score as int) as highest_score,
	most_selected,
	most_captained ,
	most_vice_captained,
	most_transferred_in,
	top_element,
	try_cast(transfers_made as int) as total_transfers,
	season ,
	deadline_time,
	finished, 
	is_current,
	is_previous
from fpl_fantasy.dbo.stg_fantasy_gw
