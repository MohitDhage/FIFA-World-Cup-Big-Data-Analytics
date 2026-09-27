# ============================================================
# FIFA WORLD CUP BIG DATA ANALYTICS
# STEP 2 - LOAD AND INSPECT DATA
# ============================================================

cat("============================================\n")
cat(" FIFA WORLD CUP BIG DATA ANALYTICS\n")
cat(" DATA LOADING AND INSPECTION\n")
cat("============================================\n\n")

# ------------------------------------------------------------
# 1. Load datasets
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
# 2. Dataset summary function
# ------------------------------------------------------------

show_dataset_info <- function(data, name) {

  cat("\n--------------------------------------------\n")
  cat(name, "\n")
  cat("--------------------------------------------\n")

  cat("Rows    :", nrow(data), "\n")
  cat("Columns :", ncol(data), "\n")

  cat("\nColumns:\n")
  print(names(data))

  cat("\nFirst 3 rows:\n")
  print(head(data, 3))
}


# ------------------------------------------------------------
# 3. Inspect every dataset
# ------------------------------------------------------------

show_dataset_info(
  matches,
  "MATCHES"
)

show_dataset_info(
  matches_detailed,
  "MATCHES DETAILED"
)

show_dataset_info(
  match_team_stats,
  "MATCH TEAM STATS"
)

show_dataset_info(
  player_stats,
  "PLAYER STATS"
)

show_dataset_info(
  squads_players,
  "SQUADS AND PLAYERS"
)

show_dataset_info(
  teams,
  "TEAMS"
)

show_dataset_info(
  tournament_stages,
  "TOURNAMENT STAGES"
)


# ------------------------------------------------------------
# 4. Missing value analysis
# ------------------------------------------------------------

cat("\n\n============================================\n")
cat(" MISSING VALUE ANALYSIS\n")
cat("============================================\n")


check_missing <- function(data, name) {

  missing <- colSums(is.na(data))

  cat("\n", name, "\n", sep = "")
  print(missing)
}


check_missing(matches, "MATCHES")
check_missing(matches_detailed, "MATCHES DETAILED")
check_missing(match_team_stats, "MATCH TEAM STATS")
check_missing(player_stats, "PLAYER STATS")
check_missing(squads_players, "SQUADS AND PLAYERS")
check_missing(teams, "TEAMS")
check_missing(tournament_stages, "TOURNAMENT STAGES")


cat("\n============================================\n")
cat(" DATA INSPECTION COMPLETE\n")
cat("============================================\n")