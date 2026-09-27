# ============================================================
# FIFA WORLD CUP BIG DATA ANALYTICS
# MODERN FRONTEND DASHBOARD
# ============================================================

library(shiny)
library(ggplot2)

# ============================================================
# LOAD DATA
# ============================================================

team_data <- read.csv(
  "data/processed/final_team_dataset.csv",
  stringsAsFactors = FALSE
)

player_data <- read.csv(
  "data/processed/clean_player_stats.csv",
  stringsAsFactors = FALSE
)

# Make sure numeric fields are numeric
player_data$goals <- as.numeric(player_data$goals)
player_data$assists <- as.numeric(player_data$assists)
player_data$matches_played <- as.numeric(player_data$matches_played)
player_data$minutes_played <- as.numeric(player_data$minutes_played)

# ============================================================
# UI
# ============================================================

ui <- fluidPage(

  # ----------------------------------------------------------
  # CUSTOM CSS
  # ----------------------------------------------------------

  tags$head(

    tags$style(HTML("
      
      body {
        background: #f4f6f9;
        font-family: 'Segoe UI', Arial, sans-serif;
        color: #172033;
        margin: 0;
      }

      /* ================= HEADER ================= */

      .topbar {
        background: #101828;
        color: white;
        padding: 18px 45px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 0;
      }

      .brand {
        font-size: 22px;
        font-weight: 700;
        letter-spacing: 0.5px;
      }

      .brand span {
        font-weight: 400;
        opacity: 0.75;
      }

      .nav-text {
        font-size: 14px;
        opacity: 0.8;
      }

      /* ================= HERO ================= */

      .hero {
        background: linear-gradient(
          135deg,
          #101828 0%,
          #1d2939 60%,
          #344054 100%
        );
        color: white;
        padding: 55px 55px 65px 55px;
      }

      .hero-title {
        font-size: 46px;
        font-weight: 800;
        margin-bottom: 12px;
      }

      .hero-subtitle {
        font-size: 17px;
        opacity: 0.78;
        max-width: 700px;
        line-height: 1.6;
      }

      .hero-label {
        font-size: 12px;
        text-transform: uppercase;
        letter-spacing: 2px;
        opacity: 0.6;
        margin-bottom: 12px;
      }

      /* ================= KPI CARDS ================= */

      .kpi-row {
        margin-top: -35px;
        position: relative;
        z-index: 5;
      }

      .kpi-card {
        background: white;
        border-radius: 14px;
        padding: 24px;
        box-shadow: 0 5px 20px rgba(16,24,40,0.08);
        min-height: 120px;
        border: 1px solid #eaecf0;
      }

      .kpi-label {
        color: #667085;
        font-size: 13px;
        margin-bottom: 8px;
      }

      .kpi-value {
        font-size: 31px;
        font-weight: 750;
        color: #101828;
      }

      .kpi-small {
        color: #98a2b3;
        font-size: 12px;
        margin-top: 4px;
      }

      /* ================= SECTION ================= */

      .section {
        margin-top: 38px;
        margin-bottom: 15px;
      }

      .section-title {
        font-size: 25px;
        font-weight: 750;
        color: #101828;
        margin-bottom: 4px;
      }

      .section-subtitle {
        color: #667085;
        font-size: 14px;
        margin-bottom: 22px;
      }

      /* ================= PANELS ================= */

      .panel-card {
        background: white;
        border: 1px solid #eaecf0;
        border-radius: 14px;
        padding: 24px;
        margin-bottom: 25px;
        box-shadow: 0 3px 12px rgba(16,24,40,0.04);
      }

      .panel-title {
        font-size: 17px;
        font-weight: 700;
        margin-bottom: 5px;
      }

      .panel-description {
        color: #667085;
        font-size: 13px;
        margin-bottom: 18px;
      }

      /* ================= SELECT ================= */

      .selectize-input {
        border-radius: 9px !important;
        border: 1px solid #d0d5dd !important;
        min-height: 42px !important;
      }

      .control-label {
        font-size: 13px;
        font-weight: 600;
        color: #344054;
      }

      /* ================= TEAM PROFILE ================= */

      .team-name {
        font-size: 30px;
        font-weight: 800;
        margin-top: 8px;
        margin-bottom: 18px;
      }

      .stat-box {
        background: #f9fafb;
        border-radius: 10px;
        padding: 15px;
        text-align: center;
        border: 1px solid #eaecf0;
      }

      .stat-number {
        font-size: 22px;
        font-weight: 750;
        color: #101828;
      }

      .stat-label {
        font-size: 11px;
        color: #667085;
        margin-top: 4px;
      }

      /* ================= PLAYER TABLE ================= */

      .player-highlight {
        background: #f9fafb;
        border-radius: 10px;
        padding: 15px 18px;
        margin-bottom: 10px;
        border: 1px solid #eaecf0;
      }

      .player-rank {
        font-size: 18px;
        font-weight: 750;
        width: 35px;
        display: inline-block;
      }

      .player-name {
        font-weight: 650;
      }

      .player-value {
        float: right;
        font-weight: 750;
      }

      /* ================= FOOTER ================= */

      .footer {
        margin-top: 60px;
        background: #101828;
        color: white;
        padding: 30px 45px;
        text-align: center;
        font-size: 13px;
        opacity: 0.95;
      }

      .footer-small {
        opacity: 0.55;
        margin-top: 5px;
      }

      /* ================= RESPONSIVE ================= */

      @media (max-width: 768px) {

        .hero {
          padding: 40px 25px;
        }

        .hero-title {
          font-size: 34px;
        }

        .topbar {
          padding: 15px 25px;
        }

        .kpi-row {
          margin-top: 15px;
        }

      }

    ")),

    # ========================================================
    # HEADER
    # ========================================================

    tags$div(
      class = "topbar",

      tags$div(
        class = "brand",
        "⚽ FIFA WORLD CUP ",
        tags$span("Analytics")
      ),

      tags$div(
        class = "nav-text",
        "BIG DATA ANALYTICS • R + SHINY"
      )
    )

  ),

  # ==========================================================
  # HERO
  # ==========================================================

  tags$div(
    class = "hero",

    tags$div(
      class = "hero-label",
      "Football Data Intelligence"
    ),

    tags$div(
      class = "hero-title",
      "World Cup Analytics"
    ),

    tags$div(
      class = "hero-subtitle",
      paste(
        "Explore team performance, player statistics and match",
        "metrics through an interactive analytics platform built",
        "with R and Shiny."
      )
    )
  ),

  # ==========================================================
  # KPI CARDS
  # ==========================================================

  fluidRow(
    class = "kpi-row",

    column(
      3,
      div(
        class = "kpi-card",
        div(class = "kpi-label", "TEAMS"),
        div(class = "kpi-value", nrow(team_data)),
        div(class = "kpi-small", "Teams analysed")
      )
    ),

    column(
      3,
      div(
        class = "kpi-card",
        div(class = "kpi-label", "MATCHES"),
        div(class = "kpi-value", "104"),
        div(class = "kpi-small", "Matches in dataset")
      )
    ),

    column(
      3,
      div(
        class = "kpi-card",
        div(class = "kpi-label", "PLAYERS"),
        div(class = "kpi-value", nrow(player_data)),
        div(class = "kpi-small", "Player records")
      )
    ),

    column(
      3,
      div(
        class = "kpi-card",
        div(class = "kpi-label", "TOTAL GOALS"),
        div(class = "kpi-value", "308"),
        div(class = "kpi-small", "Goals recorded")
      )
    )
  ),

  # ==========================================================
  # TEAM PERFORMANCE
  # ==========================================================

  div(
    class = "section",

    div(
      class = "section-title",
      "Team Performance"
    ),

    div(
      class = "section-subtitle",
      "Explore results, attacking output and possession."
    )
  ),

  fluidRow(

    column(
      4,

      div(
        class = "panel-card",

        div(
          class = "panel-title",
          "Team Explorer"
        ),

        div(
          class = "panel-description",
          "Select a team to inspect its performance."
        ),

        selectInput(
          "team",
          "Select Team",
          choices = sort(team_data$team),
          selected = "Spain"
        ),

        uiOutput("team_profile")

      )
    ),

    column(
      8,

      div(
        class = "panel-card",

        div(
          class = "panel-title",
          "Team Results"
        ),

        div(
          class = "panel-description",
          "Wins, draws and losses for the selected team."
        ),

        plotOutput(
          "team_results",
          height = "330px"
        )
      )
    )
  ),

  # ==========================================================
  # TEAM COMPARISON
  # ==========================================================

  fluidRow(

    column(
      6,

      div(
        class = "panel-card",

        div(
          class = "panel-title",
          "Top Teams by Points"
        ),

        div(
          class = "panel-description",
          "Points accumulated across the dataset."
        ),

        plotOutput(
          "points_chart",
          height = "350px"
        )
      )
    ),

    column(
      6,

      div(
        class = "panel-card",

        div(
          class = "panel-title",
          "Goals Scored vs Conceded"
        ),

        div(
          class = "panel-description",
          "Attacking output compared with goals conceded."
        ),

        plotOutput(
          "goals_chart",
          height = "350px"
        )
      )
    )
  ),

  # ==========================================================
  # PLAYER INSIGHTS
  # ==========================================================

  div(
    class = "section",

    div(
      class = "section-title",
      "Player Insights"
    ),

    div(
      class = "section-subtitle",
      "Explore the leading players across different performance metrics."
    )
  ),

  fluidRow(

    column(
      4,

      div(
        class = "panel-card",

        div(
          class = "panel-title",
          "Player Metric"
        ),

        div(
          class = "panel-description",
          "Choose a metric for the leaderboard."
        ),

        selectInput(
          "player_metric",
          "Metric",
          choices = c(
            "Goals" = "goals",
            "Assists" = "assists",
            "Matches Played" = "matches_played",
            "Minutes Played" = "minutes_played"
          ),
          selected = "goals"
        ),

        uiOutput("player_leaderboard")

      )
    ),

    column(
      8,

      div(
        class = "panel-card",

        div(
          class = "panel-title",
          "Player Leaderboard"
        ),

        div(
          class = "panel-description",
          "Top 10 players based on the selected metric."
        ),

        plotOutput(
          "player_chart",
          height = "430px"
        )
      )
    )
  ),

  # ==========================================================
  # MATCH STATISTICS
  # ==========================================================

  div(
    class = "section",

    div(
      class = "section-title",
      "Match Statistics"
    ),

    div(
      class = "section-subtitle",
      "Compare possession, shooting and other match-level indicators."
    )
  ),

  fluidRow(

    column(
      6,

      div(
        class = "panel-card",

        div(
          class = "panel-title",
          "Total Shots"
        ),

        div(
          class = "panel-description",
          "Teams with the highest number of recorded shots."
        ),

        plotOutput(
          "shots_chart",
          height = "390px"
        )
      )
    ),

    column(
      6,

      div(
        class = "panel-card",

        div(
          class = "panel-title",
          "Average Possession"
        ),

        div(
          class = "panel-description",
          "Teams with the highest average possession."
        ),

        plotOutput(
          "possession_chart",
          height = "390px"
        )
      )
    )
  ),

  # ==========================================================
  # FOOTER
  # ==========================================================

  tags$div(
    class = "footer",

    "FIFA World Cup Big Data Analytics",

    tags$div(
      class = "footer-small",
      "Built with R • ggplot2 • Shiny"
    )
  )

)

# ============================================================
# SERVER
# ============================================================

server <- function(input, output, session) {

  # ----------------------------------------------------------
  # SELECTED TEAM
  # ----------------------------------------------------------

  selected_team <- reactive({

    team_data[
      team_data$team == input$team,
    ]

  })

  # ----------------------------------------------------------
  # TEAM PROFILE
  # ----------------------------------------------------------

  output$team_profile <- renderUI({

    team <- selected_team()

    tagList(

      div(
        class = "team-name",
        team$team
      ),

      fluidRow(

        column(
          6,
          div(
            class = "stat-box",
            div(
              class = "stat-number",
              team$points
            ),
            div(
              class = "stat-label",
              "POINTS"
            )
          )
        ),

        column(
          6,
          div(
            class = "stat-box",
            div(
              class = "stat-number",
              paste0(
                team$win_percentage,
                "%"
              )
            ),
            div(
              class = "stat-label",
              "WIN RATE"
            )
          )
        )

      ),

      br(),

      fluidRow(

        column(
          6,
          div(
            class = "stat-box",
            div(
              class = "stat-number",
              team$goals_for
            ),
            div(
              class = "stat-label",
              "GOALS"
            )
          )
        ),

        column(
          6,
          div(
            class = "stat-box",
            div(
              class = "stat-number",
              team$average_possession
            ),
            div(
              class = "stat-label",
              "POSSESSION %"
            )
          )
        )

      )

    )

  })

  # ----------------------------------------------------------
  # TEAM RESULTS
  # ----------------------------------------------------------

  output$team_results <- renderPlot({

    team <- selected_team()

    data <- data.frame(
      Result = c(
        "Wins",
        "Draws",
        "Losses"
      ),
      Count = c(
        team$wins,
        team$draws,
        team$losses
      )
    )

    ggplot(
      data,
      aes(
        x = Result,
        y = Count
      )
    ) +

      geom_col() +

      geom_text(
        aes(label = Count),
        vjust = -0.4,
        fontface = "bold"
      ) +

      labs(
        title = team$team,
        x = NULL,
        y = "Matches"
      ) +

      theme_minimal(base_size = 13) +

      theme(
        plot.title = element_text(
          face = "bold",
          size = 16
        ),
        panel.grid.minor = element_blank()
      )

  })

  # ----------------------------------------------------------
  # POINTS CHART
  # ----------------------------------------------------------

  output$points_chart <- renderPlot({

    top <- head(
      team_data[
        order(
          -team_data$points,
          -team_data$goal_difference
        ),
      ],
      10
    )

    ggplot(
      top,
      aes(
        x = reorder(team, points),
        y = points
      )
    ) +

      geom_col() +

      coord_flip() +

      geom_text(
        aes(label = points),
        hjust = -0.2,
        fontface = "bold"
      ) +

      labs(
        x = NULL,
        y = "Points"
      ) +

      theme_minimal(base_size = 12) +

      theme(
        panel.grid.minor = element_blank()
      )

  })

  # ----------------------------------------------------------
  # GOALS SCATTER
  # ----------------------------------------------------------

  output$goals_chart <- renderPlot({

    ggplot(
      team_data,
      aes(
        x = goals_for,
        y = goals_against
      )
    ) +

      geom_point(
        size = 3
      ) +

      labs(
        x = "Goals Scored",
        y = "Goals Conceded"
      ) +

      theme_minimal(base_size = 12) +

      theme(
        panel.grid.minor = element_blank()
      )

  })

  # ----------------------------------------------------------
  # PLAYER LEADERBOARD
  # ----------------------------------------------------------

  output$player_leaderboard <- renderUI({

    metric <- input$player_metric

    player_data$metric_value <-
      player_data[[metric]]

    top <- head(
      player_data[
        order(
          -player_data$metric_value
        ),
      ],
      5
    )

    items <- lapply(
      seq_len(nrow(top)),
      function(i) {

        div(
          class = "player-highlight",

          span(
            class = "player-rank",
            paste0(
              "#",
              i
            )
          ),

          span(
            class = "player-name",
            top$player_name[i]
          ),

          span(
            class = "player-value",
            top$metric_value[i]
          )

        )

      }
    )

    tagList(items)

  })

  # ----------------------------------------------------------
  # PLAYER CHART
  # ----------------------------------------------------------

  output$player_chart <- renderPlot({

    metric <- input$player_metric

    player_data$metric_value <-
      player_data[[metric]]

    top <- head(
      player_data[
        order(
          -player_data$metric_value
        ),
      ],
      10
    )

    ggplot(
      top,
      aes(
        x = reorder(
          player_name,
          metric_value
        ),
        y = metric_value
      )
    ) +

      geom_col() +

      coord_flip() +

      labs(
        x = NULL,
        y = tools::toTitleCase(
          gsub(
            "_",
            " ",
            metric
          )
        )
      ) +

      theme_minimal(base_size = 12) +

      theme(
        panel.grid.minor = element_blank()
      )

  })

  # ----------------------------------------------------------
  # SHOTS
  # ----------------------------------------------------------

  output$shots_chart <- renderPlot({

    top <- head(
      team_data[
        order(
          -team_data$total_shots
        ),
      ],
      10
    )

    ggplot(
      top,
      aes(
        x = reorder(
          team,
          total_shots
        ),
        y = total_shots
      )
    ) +

      geom_col() +

      coord_flip() +

      labs(
        x = NULL,
        y = "Shots"
      ) +

      theme_minimal(base_size = 12) +

      theme(
        panel.grid.minor = element_blank()
      )

  })

  # ----------------------------------------------------------
  # POSSESSION
  # ----------------------------------------------------------

  output$possession_chart <- renderPlot({

    top <- head(
      team_data[
        order(
          -team_data$average_possession
        ),
      ],
      10
    )

    ggplot(
      top,
      aes(
        x = reorder(
          team,
          average_possession
        ),
        y = average_possession
      )
    ) +

      geom_col() +

      coord_flip() +

      labs(
        x = NULL,
        y = "Average Possession (%)"
      ) +

      theme_minimal(base_size = 12) +

      theme(
        panel.grid.minor = element_blank()
      )

  })

}

# ============================================================
# RUN
# ============================================================

shinyApp(
  ui = ui,
  server = server
)