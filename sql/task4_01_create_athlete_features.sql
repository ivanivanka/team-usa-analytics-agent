CREATE OR REPLACE VIEW `team_usa.athlete_features` AS
SELECT
    athlete_id,
    name,
    games_type,
    games_season,
    gender,
    CASE
        WHEN games_season = 'Winter'
            OR primary_sport IN ('Alpine Skiing', 'Cross Country Skiing',
                'Ice Hockey', 'Figure Skating', 'Speed Skating',
                'Short Track Speed Skating')
            THEN 'Winter Sports'
        WHEN primary_sport IN ('Athletics', 'Cross-Country') THEN 'Track & Field'
        WHEN primary_sport IN ('Swimming', 'Diving', 'Water Polo',
            'Artistic Swimming', 'Marathon Swimming', 'Surfing') THEN 'Aquatics'
        WHEN primary_sport IN ('Basketball', '3x3 Basketball', 'Volleyball',
            'Beach Volleyball', 'Football', 'Hockey', 'Handball',
            'Softball', 'Baseball', 'Rugby', 'Rugby Sevens',
            'Lacrosse') THEN 'Team Sports'
        WHEN primary_sport IN ('Wheelchair Basketball', 'Wheelchair Rugby',
            'Wheelchair Tennis', 'Wheelchair Fencing', 'Sitting Volleyball')
            THEN 'Wheelchair Sports'
        WHEN primary_sport IN ('Boxing', 'Wrestling', 'Judo', 'Taekwondo',
            'Fencing', 'Karate') THEN 'Combat Sports'
        WHEN primary_sport IN ('Artistic Gymnastics', 'Rhythmic Gymnastics',
            'Trampolining', 'Trampoline Gymnastics') THEN 'Gymnastics'
        WHEN primary_sport IN ('Rowing', 'Para Rowing', 'Canoe Sprint',
            'Canoe Slalom', 'Canoe Marathon', 'Sailing') THEN 'Water Sports'
        WHEN primary_sport IN ('Shooting', 'Archery') THEN 'Precision Sports'
        WHEN primary_sport LIKE 'Cycling%' THEN 'Cycling'
        WHEN primary_sport LIKE 'Equestrian%' THEN 'Equestrian'
        ELSE 'Other'
    END AS sport_category,
    CAST(games_count AS INT64) AS games_count,
    CAST(total_medals AS INT64) AS total_medals,
    CAST(gold_count AS INT64) AS gold_count,
    CAST(last_games_year AS INT64) - CAST(first_games_year AS INT64) AS career_span,
    ROUND(SAFE_DIVIDE(total_medals, games_count), 2) AS medal_rate,
    ROUND(SAFE_DIVIDE(gold_count, total_medals), 2) AS gold_ratio,
    CASE
        WHEN games_type = 'Olympic' THEN 'OLYMPIC'
        WHEN classification_code IS NULL OR TRIM(classification_code) = ''
            THEN 'UNCLASSIFIED'
        ELSE 'CLASSIFIED'
    END AS classification_group
FROM `team_usa.athletes`
WHERE games_count IS NOT NULL
AND total_medals > 0;
