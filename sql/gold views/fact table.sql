use fpl_fantasy
go
create or alter view dbo.fact_table as

with gw_corrected as (
    select
        g.*,
        case 
            when g.player_code = '437730' and g.season = '2526' and g.gw < 22 then '4' -- updating semenyos team id to bournmouth pre transfer
            when g.player_code = '232413' and g.season = '2526' and g.gw < 3  then '8' -- updating ezes team id to crystal palace pre transfer
            when g.player_code = '209036' and g.season = '2526' and g.gw < 23 then '8' -- updating guehis team id to crystal palace pre transfer
            when g.player_code = '247412' and g.season = '2526' and g.gw < 25 then '20' -- updating strand larsons team id to crystal palace pre transfer
            when g.player_code = '477555' and g.season = '2526' and g.gw < 24 then '13' -- updating oscar bobbs team id to crystal palace pre transfer
            when g.player_code = '242898' and g.season = '2526' and g.gw < 20 then '18'-- updating brennan johnsons team id to crystal palace pre transfer
			when g.player_code = '101178' and g.season = '2526' and g.gw < 24 then '19'-- updating ward prowse team id to west ham pre transfer
			when g.player_code = '223434' and g.season = '2526' and g.gw < 24 then '6' -- updating igor julios team id to brighton pre transfer
			when g.player_code = '493105' and g.season = '2526' and g.gw < 4  then '14' -- updating garnachos team id to man united pre transfer
			when g.player_code = '499309' and g.season = '2526' and g.gw < 4  then '17' -- updating marc guiu team id to sunderland pre transfer
			when g.player_code = '533463' and g.season = '2526' and g.gw < 2  then '4' -- updating dangos team id to bournmouth pre tansfer
			when g.player_code = '200641' and g.season = '2526' and g.gw < 4  then '1' -- updating reiss nelsons team id to arsenal pre tansfer
			when g.player_code = '209243' and g.season = '2526' and g.gw < 11 then '14' -- updating sanchos team id to man u pre tansfer
			when g.player_code = '444884' and g.season = '2526' and g.gw < 4  then '12' -- updating harvey elliots team id to	liverpool pre tansfer
			when g.player_code = '230046' and g.season = '2526' and g.gw < 24 then '16' -- updating douglas luizs team id to nott forest pre tansfer
			when g.player_code = '485337' and g.season = '2526' and g.gw < 25 then '2' -- updating guessands team id to villa pre tansfer
			when g.player_code = '550615' and g.season = '2526' and g.gw < 25 then '7' -- updating tyrique georges team id to	chelsea pre tansfer
			when g.player_code = '138001' and g.season = '2526' and g.gw < 2  then '20' -- updating tom kings team id to wolves pre tansfer
			when g.player_code = '536916' and g.season = '2526' and g.gw < 4  then '6' -- updating buononotte team id to brighton pre tansfer
			when g.player_code = '536916' and g.season = '2526' and g.gw >= 4 and g.gw <22  then '7' -- updating buonanottes teamid to chelsea
			when g.player_code = '219168' and g.season = '2526' and g.gw < 4  then '15' -- updating isaks team id to newcastle pre tansfer
			when g.player_code = '216646' and g.season = '2526' and g.gw < 4  then '15' -- updating wissas team id to newcastle pre tansfer
			when g.player_code = '88248' and g.season = '2526' and g.gw < 25  then '13' -- updating stef ortega team id to man city pre tansfer
			when g.player_code = '206325' and g.season = '2526' and g.gw < 5  then '1' -- updating zinchenko team id to arsenal pre tansfer
			when g.player_code = '159533' and g.season = '2526' and g.gw < 24 then '10' -- updating a.traore team id to fuhlam pre tansfer
            else g.team_id
        end as team_id_corrected             -- when pulling the data there was some issues with team ids for transfered players hence the need for the updates
    from v_gameweek g
),

gw_code_join as(
select
	g.*,
	t.code as team_code,                  -- bringing in teamcodes because theyre global and fixed where as team ids are season relative
	te.code as opp_code
from gw_corrected g
left join v_teams t
on g.team_id_corrected = t.id and g.season = t.season
left join v_teams te
on g.opp_id = te.id and g.season = te.season
)

select
    player_code as code,
	g.gw,
	price,
	goals,
    g.fixture_id,
	assists,
	g.minutes, 
	selected_perc,
	goals_conceded,
	clean_sheets,
	yellows,
	reds,
	bonus,
	bps,
	points,
	xg,
	xa,
	xgi,
	xgc,
	defcon,
	ict_index,
	influence,
	creativity,
	threat,
	cast(corners_indirect_fk_rank as int) as corners_indirect_fk_rank,
	cast(direct_fk_rank as int) as direct_fk_rank,
	cast(pen_rank as int) as pen_rank,
	g.season,
	news,
	in_dreamteam,
	status,
	h_a,
	left(kickoff_time,10) as date,
	cast((player_code + g.season) as bigint) as playerkey,
	cast((team_code + g.season) as int) as teamkey,
	cast((opp_code + g.season) as int) as oppkey,
	cast((g.fixture_id + g.season) as int) as fixkey,
	p.final_score,
	p.xgi_score
from gw_code_join g
left join v_player_scores p
on g.player_code = p.code
and g.season = p.season
and g.fixture_id = p.fixture_id;