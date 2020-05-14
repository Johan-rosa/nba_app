# Packages -------------------------------------------------------------------------
library(tidyverse)
library(lubridate)
library(janitor)
library(ggridges)

# Importing files ------------------------------------------------------------------

# data sets --- --- 
player_data <- read_csv("data/player_data.csv")
players <- read_csv("data/Players.csv")
seasons_stats <- read.csv("data/Seasons_Stats.csv")

# players with pic vector --- ---
players_with_pic <- list.files("nba_apps/player_pic") %>%
  str_remove(".png") %>%
  str_replace("_", " ")



# Manipulating variables -----------------------------------------------------------

# seasons stats --- ---

seasons_stats <- seasons_stats %>%
  select(-X) %>%
  clean_names() %>% glimpse()
  
original_names <- c(
  "year", "player", "pos", "age", "tm", "g", "gs", "mp", "per", 
  "ts", "x3p_ar", "f_tr", "orb", "drb", "trb", "ast", "stl", "blk", 
  "tov", "usg", "blanl", "ows", "dws", "ws", "ws_48", "blank2", 
  "obpm", "dbpm", "bpm", "vorp", "fg", "fga", "fg_2", "x3p", "x3pa", 
  "x3p_2", "x2p", "x2pa", "x2p_2", "e_fg", "ft", "fta", "ft_2", 
  "orb_2", "drb_2", "trb_2", "ast_2", "stl_2", "blk_2", "tov_2", 
  "pf", "pts")

names_df <- c(
 "year", "player", "position", "age", "team", "games", "games_started",
 "minutes_played", "efficiency_rating", "true_shooting_p", "rate_3p_attemp",
 "ft_rate", "orb_p", "drb_p", "trb_p", "assist_p", "steal_p", "block_p",
 "turnover_p", "usage_p", "blank", "offensive_win_share", "defensive_win_share",
 "win_share", "win_share_48m", "blank2", "offensive_box", "defensive_box", 
 "box_plus_minus", "value_o_replacement", "fg", "fga",
 "fg_p", "fg_3p", "fg_3pa", "fg_3p_p", "fg_2p", "fg_2pa", "fg_2p_p",
 "effic_fg_p", "ft", "fta", "ft_p", "orb", "drb", "trb", "assist", "steal",
 "blocks", "turnovers", "personal_fouls", "points"
)

names(seasons_stats) <- names_df 


# Players data --- ---

player_data <- player_data %>%
  separate(col = height, c("feets", "inches"), convert = TRUE) %>%
  mutate(
    birth_date = mdy(birth_date),
    height1 = (feets * 30.48 + inches * 2.54)
  )

player_full <- player_data %>%
  left_join( select(players, -X1), by = c("name" = "Player"))

player_full %>%
  mutate(
    height1 =height1/100,
    height_branch = case_when(
      height1 < 1.828 ~ "<6'0''",
      height1 >= 1.828 | height1 < 1.905 ~ "6'0'' - 6'3''",
      height1 >= 1.905 | height1 < 1.981 ~ "6'3'' - 6'6''",
      height1 >= 1.981 | height1 < 2.057 ~ "6'6'' - 6'9''",
      TRUE ~ "7'0'' o más"
    )
  ) %>%
  count(height_branch)

# EDA Basketball ----------------------------------------------------------------

# Player data -------------------------------------------------------------------


seasons_stats %>%
  filter(player == "Kobe Bryant") %>%
  ggplot(
    aes(x = year, y = games)
  ) +
  geom_col()








