go
create or alter view dbo.v_player as
select
	id,
	code,
	try_cast(element_type as int) as position_id,
    season as season_id,
	TRANSLATE(first_name, 'àáâãäåèéêëìíîïòóôõöøùúûüçñÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖØÙÚÛÜÇÑ', 'aaaaaaeeeeiiiioooooouuuucnAAAAAAEEEEIIIIOOOOOOUUUUCN') as first_name,
	TRANSLATE(second_name, 'àáâãäåèéêëìíîïòóôõöøùúûüçñÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖØÙÚÛÜÇÑ', 'aaaaaaeeeeiiiioooooouuuucnAAAAAAEEEEIIIIOOOOOOUUUUCN') as second_name,
	TRANSLATE(web_name, 'àáâãäåèéêëìíîïòóôõöøùúûüçñÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖØÙÚÛÜÇÑ', 'aaaaaaeeeeiiiioooooouuuucnAAAAAAEEEEIIIIOOOOOOUUUUCN') as web_name,
	photo,
	case
		when TRANSLATE(web_name, 'àáâãäåèéêëìíîïòóôõöøùúûüçñÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖØÙÚÛÜÇÑ', 'aaaaaaeeeeiiiioooooouuuucnAAAAAAEEEEIIIIOOOOOOUUUUCN') like '%.%' 
		then TRANSLATE(web_name, 'àáâãäåèéêëìíîïòóôõöøùúûüçñÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖØÙÚÛÜÇÑ', 'aaaaaaeeeeiiiioooooouuuucnAAAAAAEEEEIIIIOOOOOOUUUUCN')
		else left(first_name,1) + '. ' + TRANSLATE(web_name, 'àáâãäåèéêëìíîïòóôõöøùúûüçñÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖØÙÚÛÜÇÑ', 'aaaaaaeeeeiiiioooooouuuucnAAAAAAEEEEIIIIOOOOOOUUUUCN')
	end as display_name
from dbo.stg_player;