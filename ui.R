## ui.R
library(shiny)
library(recommenderlab)
library(data.table)
library(shinyjs)
library(bslib)
library(stringr)

source('functions/sys1.R')
source('functions/sys2.R')
source('functions/visual.R')

ui <- tagList(
  tags$link(rel = "stylesheet", type = "text/css", href = "https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-star-rating@4.1.2/css/star-rating.min.css"),
  tags$link(rel = "stylesheet", type = "text/css", href = "https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-star-rating@4.1.2/themes/krajee-svg/theme.css"),
  tags$head(
    tags$script(src = "https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-star-rating@4.1.2/js/star-rating.min.js")
  ),
  tags$head(
    tags$script(src = "https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-star-rating@4.1.2/themes/krajee-svg/theme.js")
  ),
  useShinyjs(),
  navbarPage(
    id = "pages",
    theme = bs_theme(version = 5, bootswatch = "united"),
    header = tags$style(type = "text/css", "body {padding-top: 70px;}"),
    "Movie Recommender",
    fluid = TRUE,
    position = "fixed-top",
    tabPanel(
      "Recommendation by Genre",
      sidebarLayout(
        sidebarPanel(
          h5("Recommendation by Genre", style = "margin-top: 0; font-weight: bold;"),
          selectInput("genre",
                      "Select a Genre:",
                      genres),
          sliderInput(
            inputId = "topN",
            label = "Number of top movies:",
            min = 5,
            max = 25,
            value = 10
          ),
          width = 2
        ),
        mainPanel(
          h3(htmlOutput("caption"), style = "margin-top: 0;"),
          uiOutput("cards"),
          width = 10
        )
      )
    ),
    tabPanel(
      "Recommendation by Rating",
      sidebarLayout(
        sidebarPanel(
          h5("Recommendation by Rating", style = "margin-top: 0; font-weight: bold;"),
          uiOutput("moviesToRate"),
          width = 6,
          style = "padding-right: 0;"
        ),
        mainPanel(
          h3("Recommended Movies", style = "margin-top: 0;"),
          actionButton(
            "btn",
            "Click here to get your recommendations",
            class = "btn-warning",
            style = "margin-bottom: 20px;"
          ),
          uiOutput("sys2Results"),
          width = 6
        )
      )
    )
  )
)
