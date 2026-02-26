CREATE OR REPLACE MODEL `team_usa.athlete_archetypes`
OPTIONS (
    model_type = 'KMEANS',
    num_clusters = 5,
    standardize_features = TRUE,
    max_iterations = 50
) AS
SELECT
    games_type,
    gender,
    sport_category,
    games_count,
    total_medals,
    gold_count,
    career_span,
    medal_rate,
    gold_ratio,
    classification_group
FROM `team_usa.athlete_features`;
