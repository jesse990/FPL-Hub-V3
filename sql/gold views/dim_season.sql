go
create or alter view dbo.dim_season as
select
	distinct season_id,
	'20' + left(season_id,2) + '/20' + right(season_id,2) as season,
	left(season_id,2) as id
from dbo.v_player