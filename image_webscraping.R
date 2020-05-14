# Packages -------------------------------------------------------------------------
library(tidyverse)
library(rvest)

# players url ----------------------------------------------------------------------
players_df <- jsonlite::fromJSON("data/players.json", simplifyDataFrame = TRUE)

player_url <- paste0(
  "https://stats.nba.com/player/",
  players_df$playerId,
  "/traditional/"
)

player_url[1]

# Functions for webscraping --------------------------------------------------------

# function to download imagen --- ---

get_player_image <- function(url) {
  html <- read_html(url)
  
  player_id <- html %>%
    html_nodes(".player-summary__image-block") %>%
    html_nodes("img") %>%
    html_attr("player-id")
  
  team_id <- html %>%
    html_nodes(".player-summary__image-block") %>%
    html_nodes("img") %>%
    html_attr("team-id")
  
  season <- html %>%
    html_nodes(".player-summary__image-block") %>%
    html_nodes("img") %>%
    html_attr("season")
  

  img_url <- paste0(
  "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/",
  player_id,
  ".png" 
    )
    
  player <- read_html(url) %>%
    html_nodes("title") %>%
    html_text() %>%
    str_extract("(?<=\\|).*") %>%
    str_trim() %>%
    str_replace(" ", "_")

  
  download.file(
    url = img_url,
    destfile = paste0(
      "players_pic/",
      player,
      ".png"
      )
    )
  
  return(img_url)
  
}


# Getting images -------------------------------------------------------------------

map(
  player_url,
  possibly(get_player_image, otherwise = NA)
)

get_player_image(player_url[1])

