# matt-dray/whe-hockey
# Create plot of results

# Load packages -----------------------------------------------------------

library(readr)
library(dplyr)
library(ggplot2)
library(plotly)

# Plot function -----------------------------------------------------------

source("plot_pts.R")

# Plot 2017/18 ------------------------------------------------------------

plot_pts(
  file_path = "data/whe-m1-results-201718.csv",
  season = "2017/18"
) %>% 
  ggplotly()

# Plot 2018/19 ------------------------------------------------------------

plot_pts(
  file_path = "data/whe-m1-results-201819.csv",
  season = "2018/19"
) %>% 
  ggplotly()
