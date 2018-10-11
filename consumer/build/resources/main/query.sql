
with individual_results AS (
  select home_id as team, home_goals as goals_in_favor, away_goals as goals_against
    from hive.default.matches
      union
  select away_id as team, away_goals as goals_in_favor, home_goals as goals_against
    from hive.default.matches
  )
select t.team_name, t.team_id, coalesce( sum(
                                    CASE
                                      WHEN goals_in_favor > goals_against THEN 3
                                      WHEN goals_in_favor = goals_against THEN 1
                                    END), 0 ) as points
  from postgresql.public.teams t left join individual_results ir on (t.team_id = ir.team)
  group by 1,2
  order by points desc

