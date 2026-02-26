SELECT COUNT(*) AS medalist_count FROM `team_usa.athlete_features`;

SELECT archetype_name, COUNT(*) AS athlete_count
FROM `team_usa.athlete_profiles`
GROUP BY archetype_name
ORDER BY athlete_count DESC;

SELECT
  name,
  primary_sport,
  archetype_name,
  archetype_description,
  games_count,
  total_medals,
  gold_count,
  medal_rate
FROM `team_usa.athlete_profiles`
WHERE name LIKE '%Michael Phelps%';
