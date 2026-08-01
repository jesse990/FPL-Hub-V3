go 
create or alter view v_teams as
select
	team_id  as id,
	team_code as code,
	season,
	team_name as name,
	team_short_name as short_name,
	badge_url as badge
from stg_team