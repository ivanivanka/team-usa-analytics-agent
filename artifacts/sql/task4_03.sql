CREATE OR REPLACE VIEW `team_usa.athlete_profiles` AS
WITH predictions AS (
  SELECT *
  FROM ML.PREDICT(
    MODEL `team_usa.athlete_archetypes`,
    (SELECT * FROM `team_usa.athlete_features`)
  )
)
SELECT
  a.athlete_id,
  a.name,
  a.primary_sport,
  a.games_type,
  a.games_season,
  COALESCE(p.CENTROID_ID, 0) AS centroid_id,
  CASE p.CENTROID_ID
    WHEN 1 THEN 'Competitive Paralympians'
    WHEN 2 THEN 'The Elite Achievers'
    WHEN 3 THEN 'The Core Population'
    WHEN 4 THEN 'The Veterans'
    WHEN 5 THEN 'Team Sports Specialists'
    ELSE 'Competitor'
  END AS archetype_name,
  CASE p.CENTROID_ID
    WHEN 1 THEN 'Paralympic-dominant, high efficiency in few Games, primarily Track and Field and Aquatics.'
    WHEN 2 THEN 'Most decorated athletes averaging 8+ medals and 4.5+ golds, primarily Paralympic.'
    WHEN 3 THEN 'Largest cluster, typical single Games appearance with fewer podium finishes.'
    WHEN 4 THEN 'Highest longevity, 3+ Games appearances, mostly Olympic with steady medal contributions.'
    WHEN 5 THEN 'Mostly Olympic athletes in team sports with strong average gold count.'
    ELSE 'Team USA athlete who competed on the world stage.'
  END AS archetype_description,
  COALESCE(f.games_count, a.games_count) AS games_count,
  COALESCE(f.total_medals, a.total_medals) AS total_medals,
  COALESCE(f.gold_count, a.gold_count) AS gold_count,
  COALESCE(f.medal_rate, 0) AS medal_rate
FROM `team_usa.athletes` a
LEFT JOIN predictions p ON a.athlete_id = p.athlete_id
LEFT JOIN `team_usa.athlete_features` f ON a.athlete_id = f.athlete_id;
