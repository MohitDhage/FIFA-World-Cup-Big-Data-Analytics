# ============================================================
# FIFA WORLD CUP BIG DATA ANALYTICS
# STEP 5 - DATA VISUALIZATION
# ============================================================

library(ggplot2)

# ------------------------------------------------------------
# Load team analysis
# ------------------------------------------------------------

team_analysis <- read.csv(
  "data/processed/team_analysis.csv",
  stringsAsFactors = FALSE
)


# ============================================================
# GRAPH 1 - TOP 10 TEAMS BY WINS
# ============================================================

top_wins <- head(
  team_analysis[
    order(-team_analysis$wins),
  ],
  10
)

p1 <- ggplot(
  top_wins,
  aes(
    x = reorder(team, wins),
    y = wins
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Teams by Number of Wins",
    x = "Team",
    y = "Wins"
  ) +
  theme_minimal()

print(p1)

ggsave(
  "output/plots/top_10_wins.png",
  p1,
  width = 10,
  height = 6
)


# ============================================================
# GRAPH 2 - TOP 10 TEAMS BY GOALS SCORED
# ============================================================

top_goals <- head(
  team_analysis[
    order(-team_analysis$goals_for),
  ],
  10
)

p2 <- ggplot(
  top_goals,
  aes(
    x = reorder(team, goals_for),
    y = goals_for
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Teams by Goals Scored",
    x = "Team",
    y = "Goals Scored"
  ) +
  theme_minimal()

print(p2)

ggsave(
  "output/plots/top_10_goals.png",
  p2,
  width = 10,
  height = 6
)


# ============================================================
# GRAPH 3 - GOALS SCORED VS GOALS CONCEDED
# ============================================================

p3 <- ggplot(
  team_analysis,
  aes(
    x = goals_for,
    y = goals_against
  )
) +
  geom_point(size = 3) +
  labs(
    title = "Goals Scored vs Goals Conceded",
    x = "Goals Scored",
    y = "Goals Conceded"
  ) +
  theme_minimal()

print(p3)

ggsave(
  "output/plots/goals_scored_vs_conceded.png",
  p3,
  width = 10,
  height = 6
)


# ============================================================
# GRAPH 4 - WIN PERCENTAGE
# ============================================================

top_win_percentage <- head(
  team_analysis[
    order(-team_analysis$win_percentage),
  ],
  10
)

p4 <- ggplot(
  top_win_percentage,
  aes(
    x = reorder(team, win_percentage),
    y = win_percentage
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Teams by Win Percentage",
    x = "Team",
    y = "Win Percentage"
  ) +
  theme_minimal()

print(p4)

ggsave(
  "output/plots/win_percentage.png",
  p4,
  width = 10,
  height = 6
)


# ============================================================
# GRAPH 5 - GOAL DIFFERENCE
# ============================================================

top_goal_difference <- head(
  team_analysis[
    order(-team_analysis$goal_difference),
  ],
  10
)

p5 <- ggplot(
  top_goal_difference,
  aes(
    x = reorder(team, goal_difference),
    y = goal_difference
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Teams by Goal Difference",
    x = "Team",
    y = "Goal Difference"
  ) +
  theme_minimal()

print(p5)

ggsave(
  "output/plots/goal_difference.png",
  p5,
  width = 10,
  height = 6
)


# ============================================================
# GRAPH 6 - MATCH RESULTS
# ============================================================

matches <- read.csv(
  "data/processed/clean_matches.csv",
  stringsAsFactors = FALSE
)

result_counts <- as.data.frame(
  table(matches$result)
)

names(result_counts) <- c(
  "Result",
  "Matches"
)

p6 <- ggplot(
  result_counts,
  aes(
    x = Result,
    y = Matches
  )
) +
  geom_col() +
  labs(
    title = "Distribution of Match Results",
    x = "Result",
    y = "Number of Matches"
  ) +
  theme_minimal()

print(p6)

ggsave(
  "output/plots/match_results.png",
  p6,
  width = 8,
  height = 6
)


# ============================================================
# FINISHED
# ============================================================

cat("\n============================================\n")
cat(" ALL VISUALIZATIONS CREATED\n")
cat("============================================\n")

cat("\nGraphs saved in:\n")
cat("output/plots/\n")