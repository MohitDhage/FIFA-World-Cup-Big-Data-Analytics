# ============================================================
# FIFA WORLD CUP BIG DATA ANALYTICS
# STEP 6 - PLAYER ANALYSIS
# ============================================================

# ------------------------------------------------------------
# Load player data
# ------------------------------------------------------------

players <- read.csv(
  "data/processed/clean_player_stats.csv",
  stringsAsFactors = FALSE
)

# ------------------------------------------------------------
# Convert important columns to numeric
# ------------------------------------------------------------

players$goals <- as.numeric(players$goals)
players$assists <- as.numeric(players$assists)
players$matches_played <- as.numeric(players$matches_played)
players$minutes_played <- as.numeric(players$minutes_played)
players$yellow_cards <- as.numeric(players$yellow_cards)
players$red_cards <- as.numeric(players$red_cards)

# ============================================================
# ANALYSIS 1 - TOP 10 GOAL SCORERS
# ============================================================

top_scorers <- head(
  players[
    order(-players$goals),
  ],
  10
)

cat("\n============================================\n")
cat(" TOP 10 GOAL SCORERS\n")
cat("============================================\n")

print(
  top_scorers[
    c("player_name", "team_id", "position", "goals")
  ]
)

write.csv(
  top_scorers,
  "data/processed/top_10_scorers.csv",
  row.names = FALSE
)

# ============================================================
# ANALYSIS 2 - TOP 10 ASSIST PROVIDERS
# ============================================================

top_assists <- head(
  players[
    order(-players$assists),
  ],
  10
)

cat("\n============================================\n")
cat(" TOP 10 ASSIST PROVIDERS\n")
cat("============================================\n")

print(
  top_assists[
    c("player_name", "team_id", "position", "assists")
  ]
)

write.csv(
  top_assists,
  "data/processed/top_10_assists.csv",
  row.names = FALSE
)

# ============================================================
# ANALYSIS 3 - MOST APPEARANCES
# ============================================================

top_appearances <- head(
  players[
    order(-players$matches_played),
  ],
  10
)

cat("\n============================================\n")
cat(" TOP 10 PLAYERS BY MATCHES PLAYED\n")
cat("============================================\n")

print(
  top_appearances[
    c("player_name", "team_id", "position", "matches_played")
  ]
)

write.csv(
  top_appearances,
  "data/processed/top_10_appearances.csv",
  row.names = FALSE
)

# ============================================================
# ANALYSIS 4 - MOST MINUTES PLAYED
# ============================================================

top_minutes <- head(
  players[
    order(-players$minutes_played),
  ],
  10
)

cat("\n============================================\n")
cat(" TOP 10 PLAYERS BY MINUTES PLAYED\n")
cat("============================================\n")

print(
  top_minutes[
    c("player_name", "team_id", "position", "minutes_played")
  ]
)

write.csv(
  top_minutes,
  "data/processed/top_10_minutes.csv",
  row.names = FALSE
)

# ============================================================
# ANALYSIS 5 - MOST YELLOW CARDS
# ============================================================

top_yellow_cards <- head(
  players[
    order(-players$yellow_cards),
  ],
  10
)

cat("\n============================================\n")
cat(" TOP 10 PLAYERS BY YELLOW CARDS\n")
cat("============================================\n")

print(
  top_yellow_cards[
    c("player_name", "team_id", "position", "yellow_cards")
  ]
)

write.csv(
  top_yellow_cards,
  "data/processed/top_10_yellow_cards.csv",
  row.names = FALSE
)

# ============================================================
# ANALYSIS 6 - RED CARDS
# ============================================================

top_red_cards <- head(
  players[
    order(-players$red_cards),
  ],
  10
)

cat("\n============================================\n")
cat(" TOP 10 PLAYERS BY RED CARDS\n")
cat("============================================\n")

print(
  top_red_cards[
    c("player_name", "team_id", "position", "red_cards")
  ]
)

write.csv(
  top_red_cards,
  "data/processed/top_10_red_cards.csv",
  row.names = FALSE
)

# ============================================================
# SUMMARY
# ============================================================

cat("\n============================================\n")
cat(" PLAYER ANALYSIS COMPLETED\n")
cat("============================================\n")

cat("\nTotal players analyzed:", nrow(players), "\n")

cat("\nAnalysis files saved in:\n")
cat("data/processed/\n")

cat("\n============================================\n")