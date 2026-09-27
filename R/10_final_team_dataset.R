# ============================================================
# FIFA WORLD CUP BIG DATA ANALYTICS
# STEP 10 - FINAL CONSOLIDATED TEAM DATASET
# ============================================================

# ------------------------------------------------------------
# Load team performance data
# ------------------------------------------------------------

team_analysis <- read.csv(
  "data/processed/team_analysis.csv",
  stringsAsFactors = FALSE
)

# ------------------------------------------------------------
# Load match-statistics analysis
# ------------------------------------------------------------

possession <- read.csv(
  "data/processed/team_possession_analysis.csv",
  stringsAsFactors = FALSE
)

shots <- read.csv(
  "data/processed/team_shots_analysis.csv",
  stringsAsFactors = FALSE
)

shots_target <- read.csv(
  "data/processed/team_shots_on_target_analysis.csv",
  stringsAsFactors = FALSE
)

corners <- read.csv(
  "data/processed/team_corners_analysis.csv",
  stringsAsFactors = FALSE
)

fouls <- read.csv(
  "data/processed/team_fouls_analysis.csv",
  stringsAsFactors = FALSE
)

# ============================================================
# SELECT TEAM PERFORMANCE COLUMNS
# ============================================================

final_team <- team_analysis[
  c(
    "team",
    "matches_played",
    "wins",
    "draws",
    "losses",
    "goals_for",
    "goals_against",
    "goal_difference",
    "points",
    "win_percentage"
  )
]

# ============================================================
# MERGE POSSESSION
# ============================================================

final_team <- merge(
  final_team,
  possession,
  by = "team",
  all.x = TRUE
)

# ============================================================
# MERGE TOTAL SHOTS
# ============================================================

final_team <- merge(
  final_team,
  shots,
  by = "team",
  all.x = TRUE
)

# ============================================================
# MERGE SHOTS ON TARGET
# ============================================================

final_team <- merge(
  final_team,
  shots_target,
  by = "team",
  all.x = TRUE
)

# ============================================================
# MERGE CORNERS
# ============================================================

final_team <- merge(
  final_team,
  corners,
  by = "team",
  all.x = TRUE
)

# ============================================================
# MERGE FOULS
# ============================================================

final_team <- merge(
  final_team,
  fouls,
  by = "team",
  all.x = TRUE
)

# ============================================================
# ROUND POSSESSION
# ============================================================

final_team$average_possession <- round(
  final_team$average_possession,
  2
)

# ============================================================
# SORT BY POINTS
# ============================================================

final_team <- final_team[
  order(
    -final_team$points,
    -final_team$goal_difference
  ),
]

# ============================================================
# SAVE FINAL DATASET
# ============================================================

write.csv(
  final_team,
  "data/processed/final_team_dataset.csv",
  row.names = FALSE
)

# ============================================================
# DISPLAY RESULT
# ============================================================

cat("\n============================================\n")
cat(" FINAL TEAM DATASET\n")
cat("============================================\n")

cat("\nTotal teams:", nrow(final_team), "\n")
cat("Total columns:", ncol(final_team), "\n\n")

print(final_team)

# ============================================================
# SUMMARY
# ============================================================

cat("\n============================================\n")
cat(" FINAL DATASET CREATED SUCCESSFULLY\n")
cat("============================================\n")

cat("\nSaved to:\n")
cat("data/processed/final_team_dataset.csv\n")

cat("\n============================================\n")