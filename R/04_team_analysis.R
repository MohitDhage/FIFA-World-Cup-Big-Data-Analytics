# ============================================================
# FIFA WORLD CUP BIG DATA ANALYTICS
# STEP 4 - TEAM PERFORMANCE ANALYSIS
# ============================================================

cat("============================================\n")
cat(" FIFA WORLD CUP BIG DATA ANALYTICS\n")
cat(" TEAM PERFORMANCE ANALYSIS\n")
cat("============================================\n\n")


# ------------------------------------------------------------
# 1. LOAD CLEAN DATA
# ------------------------------------------------------------

team_performance <- read.csv(
  "data/processed/team_performance.csv",
  stringsAsFactors = FALSE
)


# ------------------------------------------------------------
# 2. CALCULATE TEAM STATISTICS
# ------------------------------------------------------------

team_analysis <- aggregate(
  cbind(
    goals_for,
    goals_against
  ) ~ team,
  data = team_performance,
  FUN = sum
)


# ------------------------------------------------------------
# 3. COUNT WINS
# ------------------------------------------------------------

wins <- aggregate(
  result == "Win" ~ team,
  data = team_performance,
  FUN = sum
)

names(wins)[2] <- "wins"


# ------------------------------------------------------------
# 4. COUNT DRAWS
# ------------------------------------------------------------

draws <- aggregate(
  result == "Draw" ~ team,
  data = team_performance,
  FUN = sum
)

names(draws)[2] <- "draws"


# ------------------------------------------------------------
# 5. COUNT LOSSES
# ------------------------------------------------------------

losses <- aggregate(
  result == "Loss" ~ team,
  data = team_performance,
  FUN = sum
)

names(losses)[2] <- "losses"


# ------------------------------------------------------------
# 6. COMBINE STATISTICS
# ------------------------------------------------------------

team_analysis <- merge(
  team_analysis,
  wins,
  by = "team"
)

team_analysis <- merge(
  team_analysis,
  draws,
  by = "team"
)

team_analysis <- merge(
  team_analysis,
  losses,
  by = "team"
)


# ------------------------------------------------------------
# 7. CALCULATE ADDITIONAL METRICS
# ------------------------------------------------------------

team_analysis$matches_played <-
  team_analysis$wins +
  team_analysis$draws +
  team_analysis$losses


team_analysis$goal_difference <-
  team_analysis$goals_for -
  team_analysis$goals_against


# FIFA-style points:
# Win = 3 points
# Draw = 1 point

team_analysis$points <-
  (team_analysis$wins * 3) +
  team_analysis$draws


team_analysis$win_percentage <-
  round(
    (team_analysis$wins /
       team_analysis$matches_played) * 100,
    2
  )


# ------------------------------------------------------------
# 8. SORT BY POINTS
# ------------------------------------------------------------

team_analysis <- team_analysis[
  order(
    -team_analysis$points,
    -team_analysis$goal_difference
  ),
]


# ------------------------------------------------------------
# 9. DISPLAY TOP TEAMS
# ------------------------------------------------------------

cat("\nTOP 10 TEAMS BY POINTS\n")
cat("--------------------------------------------\n")

print(
  head(team_analysis, 10)
)


# ------------------------------------------------------------
# 10. MOST SUCCESSFUL TEAM BY WINS
# ------------------------------------------------------------

top_wins <- team_analysis[
  order(-team_analysis$wins),
]

cat("\nTOP 10 TEAMS BY WINS\n")
cat("--------------------------------------------\n")

print(
  head(top_wins, 10)
)


# ------------------------------------------------------------
# 11. TOP GOAL SCORING TEAMS
# ------------------------------------------------------------

top_goals <- team_analysis[
  order(-team_analysis$goals_for),
]

cat("\nTOP 10 TEAMS BY GOALS SCORED\n")
cat("--------------------------------------------\n")

print(
  head(
    top_goals[, c(
      "team",
      "goals_for",
      "goals_against",
      "goal_difference"
    )],
    10
  )
)


# ------------------------------------------------------------
# 12. SAVE TEAM ANALYSIS
# ------------------------------------------------------------

write.csv(
  team_analysis,
  "data/processed/team_analysis.csv",
  row.names = FALSE
)


cat("\n============================================\n")
cat(" TEAM ANALYSIS COMPLETED\n")
cat("============================================\n")