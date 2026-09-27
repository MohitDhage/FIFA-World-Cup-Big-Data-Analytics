# ============================================================
# FIFA WORLD CUP BIG DATA ANALYTICS
# STEP 8 - MATCH STATISTICS ANALYSIS
# ============================================================

# ------------------------------------------------------------
# Load data
# ------------------------------------------------------------

stats <- read.csv(
  "data/processed/clean_match_team_stats.csv",
  stringsAsFactors = FALSE
)

teams <- read.csv(
  "data/raw/teams.csv",
  stringsAsFactors = FALSE
)

# ------------------------------------------------------------
# Convert numeric columns
# ------------------------------------------------------------

stats$possession_pct <- as.numeric(stats$possession_pct)
stats$total_shots <- as.numeric(stats$total_shots)
stats$shots_on_target <- as.numeric(stats$shots_on_target)
stats$corners <- as.numeric(stats$corners)
stats$fouls <- as.numeric(stats$fouls)

# ------------------------------------------------------------
# Add team names
# ------------------------------------------------------------

stats$team <- teams$team_name[
  match(stats$team_id, teams$team_id)
]

# ============================================================
# ANALYSIS 1 - AVERAGE POSSESSION
# ============================================================

possession_analysis <- aggregate(
  possession_pct ~ team,
  data = stats,
  FUN = mean
)

names(possession_analysis)[2] <- "average_possession"

possession_analysis <- possession_analysis[
  order(-possession_analysis$average_possession),
]

cat("\n============================================\n")
cat(" TOP 10 TEAMS BY AVERAGE POSSESSION\n")
cat("============================================\n")

print(head(possession_analysis, 10))

write.csv(
  possession_analysis,
  "data/processed/team_possession_analysis.csv",
  row.names = FALSE
)

# ============================================================
# ANALYSIS 2 - TOTAL SHOTS
# ============================================================

shots_analysis <- aggregate(
  total_shots ~ team,
  data = stats,
  FUN = sum
)

shots_analysis <- shots_analysis[
  order(-shots_analysis$total_shots),
]

cat("\n============================================\n")
cat(" TOP 10 TEAMS BY TOTAL SHOTS\n")
cat("============================================\n")

print(head(shots_analysis, 10))

write.csv(
  shots_analysis,
  "data/processed/team_shots_analysis.csv",
  row.names = FALSE
)

# ============================================================
# ANALYSIS 3 - SHOTS ON TARGET
# ============================================================

target_analysis <- aggregate(
  shots_on_target ~ team,
  data = stats,
  FUN = sum
)

target_analysis <- target_analysis[
  order(-target_analysis$shots_on_target),
]

cat("\n============================================\n")
cat(" TOP 10 TEAMS BY SHOTS ON TARGET\n")
cat("============================================\n")

print(head(target_analysis, 10))

write.csv(
  target_analysis,
  "data/processed/team_shots_on_target_analysis.csv",
  row.names = FALSE
)

# ============================================================
# ANALYSIS 4 - CORNERS
# ============================================================

corner_analysis <- aggregate(
  corners ~ team,
  data = stats,
  FUN = sum
)

corner_analysis <- corner_analysis[
  order(-corner_analysis$corners),
]

cat("\n============================================\n")
cat(" TOP 10 TEAMS BY CORNERS\n")
cat("============================================\n")

print(head(corner_analysis, 10))

write.csv(
  corner_analysis,
  "data/processed/team_corners_analysis.csv",
  row.names = FALSE
)

# ============================================================
# ANALYSIS 5 - FOULS
# ============================================================

foul_analysis <- aggregate(
  fouls ~ team,
  data = stats,
  FUN = sum
)

foul_analysis <- foul_analysis[
  order(-foul_analysis$fouls),
]

cat("\n============================================\n")
cat(" TOP 10 TEAMS BY FOULS\n")
cat("============================================\n")

print(head(foul_analysis, 10))

write.csv(
  foul_analysis,
  "data/processed/team_fouls_analysis.csv",
  row.names = FALSE
)

# ============================================================
# SUMMARY
# ============================================================

cat("\n============================================\n")
cat(" MATCH STATISTICS ANALYSIS COMPLETED\n")
cat("============================================\n")

cat("\nTotal team-match records:", nrow(stats), "\n")

cat("\nAnalysis files saved in:\n")
cat("data/processed/\n")

cat("\n============================================\n")