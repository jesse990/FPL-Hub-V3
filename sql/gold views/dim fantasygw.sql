use fpl_fantasy
go 
create or alter view dbo.dim_fantasy_gwm as
select
	try_cast(gw as int) as gw,
	average_score,
	highest_score,
	total_transfers,
	cast(season as int) as season,
	deadline_time,
	finished,
	is_current,
	is_previous,
	try_cast((most_selected + season) as bigint) as most_selected_element,
	try_cast((most_captained  + season)as bigint) as most_cap_element,
	try_cast((most_vice_captained  + season)as bigint) as most_vice_cap_element,
	try_cast((most_transferred_in  +season )as bigint) as most_bought_element,
	try_cast((top_element + season )as bigint) as most_points_element,
	try_cast((gw + season) as int) as gwkey
from dbo.v_fantasy_gw
GO
