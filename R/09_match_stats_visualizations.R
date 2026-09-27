# ============================================================
# FIFA WORLD CUP BIG DATA ANALYTICS
# STEP 9 - MATCH STATISTICS VISUALIZATIONS
# ============================================================

library(ggplot2)

# ============================================================
# GRAPH 1 - AVERAGE POSSESSION
# ============================================================

possession <- read.csv(
  "data/processed/team_possession_analysis.csv",
  stringsAsFactors = FALSE
)

top_possession <- head(possession, 10)

p1 <- ggplot(
  top_possession,
  aes(
    x = reorder(team, average_possession),
    y = average_possession
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Teams by Average Possession",
    x = "Team",
    y = "Average Possession (%)"
  ) +
  theme_minimal()

print(p1)

ggsave(
  "output/plots/top_10_possession.png",
  p1,
  width = 10,
  height = 6
)

# ============================================================
# GRAPH 2 - TOTAL SHOTS
# ============================================================

shots <- read.csv(
  "data/processed/team_shots_analysis.csv",
  stringsAsFactors = FALSE
)

top_shots <- head(shots, 10)

p2 <- ggplot(
  top_shots,
  aes(
    x = reorder(team, total_shots),
    y = total_shots
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Teams by Total Shots",
    x = "Team",
    y = "Total Shots"
  ) +
  theme_minimal()

print(p2)

ggsave(
  "output/plots/top_10_shots.png",
  p2,
  width = 10,
  height = 6
)

# ============================================================
# GRAPH 3 - SHOTS ON TARGET
# ============================================================

shots_target <- read.csv(
  "data/processed/team_shots_on_target_analysis.csv",
  stringsAsFactors = FALSE
)

top_shots_target <- head(shots_target, 10)

p3 <- ggplot(
  top_shots_target,
  aes(
    x = reorder(team, shots_on_target),
    y = shots_on_target
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Teams by Shots on Target",
    x = "Team",
    y = "Shots on Target"
  ) +
  theme_minimal()

print(p3)

ggsave(
  "output/plots/top_10_shots_on_target.png",
  p3,
  width = 10,
  height = 6
)

# ============================================================
# GRAPH 4 - CORNERS
# ============================================================

corners <- read.csv(
  "data/processed/team_corners_analysis.csv",
  stringsAsFactors = FALSE
)

top_corners <- head(corners, 10)

p4 <- ggplot(
  top_corners,
  aes(
    x = reorder(team, corners),
    y = corners
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Teams by Corners",
    x = "Team",
    y = "Corners"
  ) +
  theme_minimal()

print(p4)

ggsave(
  "output/plots/top_10_corners.png",
  p4,
  width = 10,
  height = 6
)

# ============================================================
# GRAPH 5 - FOULS
# ============================================================

fouls <- read.csv(
  "data/processed/team_fouls_analysis.csv",
  stringsAsFactors = FALSE
)

top_fouls <- head(fouls, 10)

p5 <- ggplot(
  top_fouls,
  aes(
    x = reorder(team, fouls),
    y = fouls
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Teams by Fouls",
    x = "Team",
    y = "Fouls"
  ) +
  theme_minimal()

print(p5)

ggsave(
  "output/plots/top_10_fouls.png",
  p5,
  width = 10,
  height = 6
)

# ============================================================
# FINISHED
# ============================================================

cat("\n============================================\n")
cat(" MATCH STATISTICS VISUALIZATIONS CREATED\n")
cat("============================================\n")

cat("\nGraphs saved in:\n")
cat("output/plots/\n")

cat("\nTotal project visualizations: 17\n")

cat("\n============================================\n")