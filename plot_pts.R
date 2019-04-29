plot_pts <- function(file_path, season) {
  
  # Prepare data
  
  whehc_results <- read_csv(file_path) %>% 
    mutate(
      details = paste0(opponent, " (", location, ") ", result, " ", goals_for, "-",  goals_against),
      result = case_when(
        result == "L" ~ "1",
        result == "D" ~ "2",
        result == "W" ~ "3"
      )
    )
  
  # Generate plot
  
  whehc_plot <- whehc_results %>% 
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
    # labs(title = "Season information goes here") +
    scale_y_continuous(breaks = unique(whehc_results$points_total)) + 
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
  
  return(whehc_plot)
  
}