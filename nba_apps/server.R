
library(shiny)
library(tidyverse)

shinyServer(function(input, output) {

    output$player_image <- renderImage({
    
        src <- input$player %>%
            str_replace(" ", "_") %>%
            paste0("players_pic/", ., ".png") 

        return(list(
            src = src,
            contentType = "image/png",
            alt = "Player"
        ))    

    }, deleteFile = FALSE)

})
