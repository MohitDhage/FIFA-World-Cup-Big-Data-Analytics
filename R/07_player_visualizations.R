# ============================================================
# FIFA WORLD CUP BIG DATA ANALYTICS
# STEP 7 - PLAYER VISUALIZATIONS
# ============================================================

library(ggplot2)

# ============================================================
# GRAPH 1 - TOP 10 GOAL SCORERS
# ============================================================

top_scorers <- read.csv(
  "data/processed/top_10_scorers.csv",
  stringsAsFactors = FALSE
)

p1 <- ggplot(
  top_scorers,
  aes(
    x = reorder(player_name, goals),
    y = goals
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Goal Scorers",
    x = "Player",
    y = "Goals"
  ) +
  theme_minimal()

print(p1)

ggsave(
  "output/plots/top_10_goal_scorers.png",
  p1,
  width = 10,
  height = 6
)

# ============================================================
# GRAPH 2 - TOP 10 ASSIST PROVIDERS
# ============================================================

top_assists <- read.csv(
  "data/processed/top_10_assists.csv",
  stringsAsFactors = FALSE
)

p2 <- ggplot(
  top_assists,
  aes(
    x = reorder(player_name, assists),
    y = assists
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Assist Providers",
    x = "Player",
    y = "Assists"
  ) +
  theme_minimal()

print(p2)

ggsave(
  "output/plots/top_10_assists.png",
  p2,
  width = 10,
  height = 6
)

# ============================================================
# GRAPH 3 - TOP 10 PLAYERS BY MATCHES PLAYED
# ============================================================

top_appearances <- read.csv(
  "data/processed/top_10_appearances.csv",
  stringsAsFactors = FALSE
)

p3 <- ggplot(
  top_appearances,
  aes(
    x = reorder(player_name, matches_played),
    y = matches_played
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Players by Matches Played",
    x = "Player",
    y = "Matches Played"
  ) +
  theme_minimal()

print(p3)

ggsave(
  "output/plots/top_10_appearances.png",
  p3,
  width = 10,
  height = 6
)

# ============================================================
# GRAPH 4 - TOP 10 PLAYERS BY MINUTES
# ============================================================

top_minutes <- read.csv(
  "data/processed/top_10_minutes.csv",
  stringsAsFactors = FALSE
)

p4 <- ggplot(
  top_minutes,
  aes(
    x = reorder(player_name, minutes_played),
    y = minutes_played
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Players by Minutes Played",
    x = "Player",
    y = "Minutes"
  ) +
  theme_minimal()

print(p4)

ggsave(
  "output/plots/top_10_minutes.png",
  p4,
  width = 10,
  height = 6
)

# ============================================================
# GRAPH 5 - TOP 10 PLAYERS BY YELLOW CARDS
# ============================================================

top_yellow <- read.csv(
  "data/processed/top_10_yellow_cards.csv",
  stringsAsFactors = FALSE
)

p5 <- ggplot(
  top_yellow,
  aes(
    x = reorder(player_name, yellow_cards),
    y = yellow_cards
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Players by Yellow Cards",
    x = "Player",
    y = "Yellow Cards"
  ) +
  theme_minimal()

print(p5)

ggsave(
  "output/plots/top_10_yellow_cards.png",
  p5,
  width = 10,
  height = 6
)

# ============================================================
# GRAPH 6 - TOP 10 PLAYERS BY RED CARDS
# ============================================================

top_red <- read.csv(
  "data/processed/top_10_red_cards.csv",
  stringsAsFactors = FALSE
)

p6 <- ggplot(
  top_red,
  aes(
    x = reorder(player_name, red_cards),
    y = red_cards
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Players by Red Cards",
    x = "Player",
    y = "Red Cards"
  ) +
  theme_minimal()

print(p6)

ggsave(
  "output/plots/top_10_red_cards.png",
  p6,
  width = 10,
  height = 6
)

# ============================================================
# FINISHED
# ============================================================

cat("\n============================================\n")
cat(" PLAYER VISUALIZATIONS CREATED\n")
cat("============================================\n")

cat("\nGraphs saved in:\n")
cat("output/plots/\n")