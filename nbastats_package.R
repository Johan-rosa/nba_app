# Instalando el paquete para manejar las estadísticas de la NBA
devtools::install_github("abresler/nbastatR")
install.packages("ballr")
 
# Cargando paquetes
library(ballr)
library(nbastatR)

# Descargando data de las temporadas que Jugó kobe Bryant
stats_season_96_16 <- 
  map(1996:2016,
  ballr::NBAPerGameStatistics
  )

kobe_season_pgame <- 
stats_season_96_16 %>%
  bind_rows() %>%
  filter(player == "Kobe Bryant")


#stats_kobe_era <- 
  stats_season_96_16 %>%
  set_names(1996:2016) %>%
  bind_rows(.id = "year") %>%
  group_by(is.kobe = player == "Kobe Bryant", year) %>%
  summarise_if(is.numeric, ~mean(., na.rm = TRUE)) 
  
    