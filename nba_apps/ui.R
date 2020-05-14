
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    titlePanel("NBA players stats"),

    sidebarLayout(
        sidebarPanel(
            selectInput("player",
                        "Player",
                        choices = players_with_pic,
                        selected = "James Harden",
                        selectize = TRUE)
        ),

        mainPanel(
            imageOutput("player_image"), 
            tableOutput("player_info")
        )
    )
))
