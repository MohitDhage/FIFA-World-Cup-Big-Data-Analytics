# ============================================================
# FIFA WORLD CUP BIG DATA ANALYTICS
# STEP 3 - DATA CLEANING AND PREPROCESSING
# ============================================================

cat("============================================\n")
cat(" FIFA WORLD CUP BIG DATA ANALYTICS\n")
cat(" DATA CLEANING AND PREPROCESSING\n")
cat("============================================\n\n")


# ------------------------------------------------------------
# 1. LOAD DATA
# ------------------------------------------------------------

matches <- read.csv(
  "data/raw/matches.csv",
  stringsAsFactors = FALSE
)

matches_detailed <- read.csv(
  "data/raw/matches_detailed.csv",
  stringsAsFactors = FALSE
)

match_team_stats <- read.csv(
  "data/raw/match_team_stats.csv",
  stringsAsFactors = FALSE
)

player_stats <- read.csv(
  "data/raw/player_stats.csv",
  stringsAsFactors = FALSE
)

squads_players <- read.csv(
  "data/raw/squads_and_players.csv",
  stringsAsFactors = FALSE
)

teams <- read.csv(
  "data/raw/teams.csv",
  stringsAsFactors = FALSE
)

tournament_stages <- read.csv(
  "data/raw/tournament_stages.csv",
  stringsAsFactors = FALSE
)


# ------------------------------------------------------------
# 2. REMOVE DUPLICATES
# ------------------------------------------------------------

matches <- unique(matches)

matches_detailed <- unique(matches_detailed)

match_team_stats <- unique(match_team_stats)

player_stats <- unique(player_stats)

squads_players <- unique(squads_players)

teams <- unique(teams)

tournament_stages <- unique(tournament_stages)


# ------------------------------------------------------------
# 3. CONVERT DATA TYPES
# ------------------------------------------------------------

matches$date <- as.Date(matches$date)

matches$home_score <- as.numeric(matches$home_score)

matches$away_score <- as.numeric(matches$away_score)

matches$home_xg <- as.numeric(matches$home_xg)

matches$away_xg <- as.numeric(matches$away_xg)


player_stats$goals <- as.numeric(player_stats$goals)

player_stats$assists <- as.numeric(player_stats$assists)

player_stats$matches_played <- as.numeric(
  player_stats$matches_played
)

player_stats$minutes_played <- as.numeric(
  player_stats$minutes_played
)


match_team_stats$possession_pct <- as.numeric(
  match_team_stats$possession_pct
)

match_team_stats$total_shots <- as.numeric(
  match_team_stats$total_shots
)

match_team_stats$shots_on_target <- as.numeric(
  match_team_stats$shots_on_target
)

match_team_stats$corners <- as.numeric(
  match_team_stats$corners
)

match_team_stats$fouls <- as.numeric(
  match_team_stats$fouls
)


# ------------------------------------------------------------
# 4. CREATE MATCH RESULT
# ------------------------------------------------------------

matches$result <- ifelse(
  matches$home_score > matches$away_score,
  "Home Win",
  ifelse(
    matches$home_score < matches$away_score,
    "Away Win",
    "Draw"
  )
)


# ------------------------------------------------------------
# 5. CREATE TOTAL GOALS
# ------------------------------------------------------------

matches$total_goals <-
  matches$home_score +
  matches$away_score


# ------------------------------------------------------------
# 6. CREATE GOAL DIFFERENCE
# ------------------------------------------------------------

matches$goal_difference <-
  abs(
    matches$home_score -
    matches$away_score
  )


# ------------------------------------------------------------
# 7. ADD TEAM NAMES
# ------------------------------------------------------------

home_team_names <- teams[
  match(
    matches$home_team_id,
    teams$team_id
  ),
  "team_name"
]

away_team_names <- teams[
  match(
    matches$away_team_id,
    teams$team_id
  ),
  "team_name"
]

matches$home_team <- home_team_names

matches$away_team <- away_team_names


# ------------------------------------------------------------
# 8. ADD STAGE NAME
# ------------------------------------------------------------

stage_names <- tournament_stages[
  match(
    matches$stage_id,
    tournament_stages$stage_id
  ),
  "stage_name"
]

matches$stage_name <- stage_names


# ------------------------------------------------------------
# 9. CREATE TEAM PERFORMANCE DATA
# ------------------------------------------------------------

home_performance <- data.frame(
  team = matches$home_team,
  opponent = matches$away_team,
  goals_for = matches$home_score,
  goals_against = matches$away_score,
  result = ifelse(
    matches$home_score > matches$away_score,
    "Win",
    ifelse(
      matches$home_score < matches$away_score,
      "Loss",
      "Draw"
    )
  )
)


away_performance <- data.frame(
  team = matches$away_team,
  opponent = matches$home_team,
  goals_for = matches$away_score,
  goals_against = matches$home_score,
  result = ifelse(
    matches$away_score > matches$home_score,
    "Win",
    ifelse(
      matches$away_score < matches$home_score,
      "Loss",
      "Draw"
    )
  )
)


team_performance <- rbind(
  home_performance,
  away_performance
)


# ------------------------------------------------------------
# 10. SAVE CLEANED DATA
# ------------------------------------------------------------

write.csv(
  matches,
  "data/processed/clean_matches.csv",
  row.names = FALSE
)

write.csv(
  team_performance,
  "data/processed/team_performance.csv",
  row.names = FALSE
)

write.csv(
  player_stats,
  "data/processed/clean_player_stats.csv",
  row.names = FALSE
)

write.csv(
  match_team_stats,
  "data/processed/clean_match_team_stats.csv",
  row.names = FALSE
)


# ------------------------------------------------------------
# 11. DISPLAY RESULTS
# ------------------------------------------------------------

cat("\n============================================\n")
cat(" CLEANING COMPLETED\n")
cat("============================================\n\n")

cat("Matches:", nrow(matches), "\n")

cat(
  "Team performance records:",
  nrow(team_performance),
  "\n"
)

cat(
  "Player records:",
  nrow(player_stats),
  "\n"
)

cat(
  "Team-match statistics:",
  nrow(match_team_stats),
  "\n"
)

cat("\nMatch results:\n")
print(table(matches$result))

cat("\nTotal goals:\n")
print(sum(matches$total_goals, na.rm = TRUE))

cat("\nAverage goals per match:\n")
print(
  round(
    mean(matches$total_goals, na.rm = TRUE),
    2
  )
)

cat("\n============================================\n")
cat(" CLEANED DATA SAVED\n")
cat("============================================\n")