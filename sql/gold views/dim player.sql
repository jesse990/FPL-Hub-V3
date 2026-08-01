use fpl_fantasy
go 
create or alter view dbo.dim_players as
select distinct
	first_name + ' ' + second_name as name,
	web_name,
	photo,
	display_name,
	cast(code as int) as code
from fpl_fantasy.dbo.v_player
GO