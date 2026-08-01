use fpl_fantasy
go
create or alter view dbo.dim_teams as 
with teamdiff as(
select distinct 
	homekey,
	away_diff
from dbo.dim_fixture
)

select
	cast(t.id as int) as id,
	cast(t.code as int) as code,
	cast(t.season as int) as season,
	t.name,
	t.short_name,
	t.badge,
	cast((t.id + t.season ) as bigint) as idkey,
	cast((t.code + t.season )as bigint) as teamkey,
	td.away_diff as team_strength

from fpl_fantasy.dbo.v_teams as t
left join teamdiff as td
on cast((t.code + t.season )as bigint) = td.homekey
GO