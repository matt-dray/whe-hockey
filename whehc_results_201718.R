library(dplyr)
library(ggplot2)
library(plotly)


results <- tibble(
  game_number = 1:22,
  location = c("A", "A", "H", "A", "H", "A", "H", "A", "H", "H", "A", "H", "H", "A", "H", "A", "A", "H", "H", "A", "H", "A"), 
  result = c(rep("L", 5),"D", rep("W", 4), "D", "W", "W", "L", "W", "W", "W", "L", "W", "W", "W", "W"),
  goals_for = c(0, 1, 0, 2, 3, 2, 4, 3, 4, 6, 2, 4, 2, 0, 2, 2, 6, 2, 4, 2, 6, 1),
  goals_against = c(5, 3, 1, 9, 9, 2, 0, 2, 0, 2, 2, 3, 1, 6, 1, 1, 1, 3, 0, 1, 4, 0),
  points = c(rep(0, 5), 1, rep(3, 4), 1, 3, 3, 0, 3, 3, 3, 0, 3, 3, 3, 3),
  points_total = c(rep(0, 5), 1, 4, 7, 10, 13, 14, 17, 20, 20, 23, 26, 29, 32, 32, 35, 38, 41),
  oppo = c(
    "Royston I",
    "Broxbourne III",
    "Rickmansworth I",
    "Potters Bar II",
    "Blueharts III",
    "Hertford II",
    "Southgate Adelaide I",
    "St Albans IV",
    "Vauxhall I",
    "Blueharts IV",
    "Harpenden II",
    "Rickmansworth I",
    "Potters Bar II",
    "Blueharts III",
    "Hertford II",
    "Southgate Adelaide I",
    "Royston I",
    "St Albans IV",
    "Harpenden II",
    "Blueharts IV",
    "Broxbourne III",
    "Vauxhall I"
    )
) %>% 
  mutate(details = paste0(oppo, " (", location, ") ", result, " ", goals_for, "-",  goals_against))

plot_pts <- results %>%
  mutate(
    result = case_when(
      result == "L" ~ "1",
      result == "D" ~ "2",
      result == "W" ~ "3"
    )
  ) %>% 
  ggplot(aes(x = game_number, y = points_total, label = details)) +
  geom_line(colour = "lightgrey") +
  geom_point(
    aes(colour = result),
    size = 3
  ) +
  geom_text(
    aes(label = details),
    size = 4,
    angle = 90,
    hjust = c(rep(-0.1, 17), rep(1.1, 5))
  ) +
  labs(
    y = "Cumulative points",
    title = "WH&EHC Men's 1st XI",
    subtitle = "Cumulative points (league 4SW, season 2017/18)"
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

plot_pts

ggplotly(plot_pts)
