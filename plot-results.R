# matt-dray/whe-hockey
# Create plot of results

# Load packages -----------------------------------------------------------

library(readr)
library(dplyr)
library(ggplot2)
library(plotly)

# Plot function -----------------------------------------------------------

plot_pts <- function(file_path, season_details) {
  
  # Prepare data
  
  results <- read_csv(file_path) %>% 
    mutate(
      details = paste0(opponent, " (", location, ") ", result, " ", goals_for, "-",  goals_against),
      result = case_when(
        result == "L" ~ "1",
        result == "D" ~ "2",
        result == "W" ~ "3"
      )
    )
  
  # Generate plot
  
  plot <- results %>% 
    ggplot(aes(x = game_number, y = points_total, label = details)) +
    geom_line(colour = "lightgrey") +
    geom_point(
      aes(colour = result),
      size = 3
    ) +
    # geom_text(
    #   aes(label = details),
    #   size = 4,
    #   angle = 90,
    #   hjust = c(rep(-0.1, 19), rep(1.1, 3))
    # ) +
    labs(
      title = "WH&EHC Men's 1st XI",
      subtitle = paste("Cumulative points", season_details)
    ) +
    scale_y_continuous(breaks = unique(results$points_total)) + 
    theme_classic() +
    theme(
      axis.line = element_blank(),
      axis.text.x = element_blank(),
      axis.title.y = element_blank(),
      axis.title.x = element_blank(),
      axis.ticks = element_blank(),
      legend.position = "none"
    ) +
    scale_colour_brewer("Purples")
  
  return(plot)
  
}


# Plot 2017/18 ------------------------------------------------------------

plot_pts(
  file_path = "data/whe-m1-results-201718.csv",
  season_details = "(third place, league 4SW, season 2017/18)"
) %>% 
  ggplotly()