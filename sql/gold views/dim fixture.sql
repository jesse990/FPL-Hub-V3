USE [fpl_fantasy]
GO

/****** Object:  View [dbo].[dim_fixture]    Script Date: 08/07/2026 17:31:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER   view [dbo].[dim_fixture] as


with fixt as(
select 
	event as gameweek,
	f.id,
	f.season ,
	f.home_score,
	f.away_score,
	f.home_diff,
	f.away_diff,
	left(f.kickoff_time, 10) as date,
	f.finished,
	t.code as away_code,
	te.code as home_code,
	t.short_name as away,
	te.short_name as home,
	t.badge as away_badge,
	te.badge as home_badge,
	cast((t.code + f.season) as bigint) as awaykey,
	cast((te.code  + f.season) as bigint) as homekey
from dbo.v_fixtures as f
left join dbo.v_teams t
on f.team_a = t.id and f.season = t.season
left join dbo.v_teams te 
on f.team_h = te.id and f.season = te.season
)

select
	id,
	season,
	gameweek,
	home_score,
	away_score,
	home_diff,
	away_diff,
	date,
	finished,
	away_code,
	home_code,
	away,
	home,
	away_badge,
	home_badge,
	awaykey,
	homekey,
	cast((id+season) as int) as fixkey
from fixt
GO
