use fpl_fantasy
go
create or alter view dbo.v_gameweek as
select
	player_id,
	player_code,
	try_cast(gameweek as int) as gw,
	case
    when charindex('.', fixture_id) >0
        then left(fixture_id, charindex('.', fixture_id)-1)
    else fixture_id
    end as fixture_id,
	try_cast(selected_by_percent as decimal) as selected_perc,
	try_cast(value as money) as price,
	team_id,
    case
        when charindex('.', opponent_id) >0
            then left(opponent_id, charindex('.', opponent_id)-1)
        else opponent_id
    end as opp_id,
	try_cast(minutes as int) as minutes,
	try_cast(goals_scored as int) as goals,
	try_cast(assists as int) as assists,
	try_cast(goals_conceded as int) as goals_conceded,
	try_cast(clean_sheets as int) as clean_sheets,
	try_cast(yellow_cards as int) as yellows,
	try_cast(red_cards as int) as reds,
	try_cast(bonus as int) as bonus,
	try_cast(bps as int) as bps,
	try_cast(total_points as int) as points,
	try_cast(xG as decimal(10,2)) as xg,
	try_cast(xA as decimal(10,2)) as xa,
	try_cast(xGI as decimal(10,2)) as xgi,
	try_cast(xGC as decimal(10,2)) as xgc,
	try_cast(DefCon as int) as defcon,
	try_cast(ict_index as decimal(10,2)) as ict_index,
	try_cast(influence as decimal(10,2)) as influence,
	try_cast(creativity as decimal(10,2)) as creativity,
	try_cast(threat as decimal) as threat,
       case
        when charindex('.', corners_indirect_freekicks_order) >0
            then left(corners_indirect_freekicks_order, charindex('.', corners_indirect_freekicks_order)-1)
        else corners_indirect_freekicks_order
        end as corners_indirect_fk_rank,
    
           case
        when charindex('.', direct_freekicks_order) >0
            then left(direct_freekicks_order, charindex('.', direct_freekicks_order)-1)
        else direct_freekicks_order
        end as direct_fk_rank,

           case
        when charindex('.', penalties_order) >0
            then left(penalties_order, charindex('.', penalties_order)-1)
        else penalties_order
        end as pen_rank,

	season,
	news,
	in_dreamteam,
	status,
	h_a,
	kickoff_time
from dbo.stg_player_gameweek


