use fpl_fantasy
go 
create or alter view dbo.dim_players as
select
	cast(id as int) as id,
	cast(code as int) as code,
	position_id,
	cast(season_id as int) as season_id,
	first_name + ' ' + second_name as name,
	web_name,
	photo,
	display_name,
	cast((id + season_id ) as bigint) as elementkey,
	cast((code +  season_id )as bigint) as playerkey,
	case
		when position_id = 1 then 'Gk'
		when position_id = 2 then 'Def'
		when position_id = 3 then 'Mid'
		when position_id = 4 then 'Fwd'
	end as position
from fpl_fantasy.dbo.v_player
GO