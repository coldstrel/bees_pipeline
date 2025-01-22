library(quarto)
library(tarchetypes)
library(targets)
library(myProject)
library(dplyr)
library(ggplot2)
source("functions.R")

list(
  tar_target(honey_data, get_data()),

  tar_target(colonies_plot,make_plot(honey_data, 1995)),

  tar_target(bee_density, plot_bee_density(honey_data, "Alabama")),

  tar_target(correlation_honey, corr_bees(honey_data, "value_of_production", "colonies_number")),

  ## Save the plots to a file directory

  tar_target(colonies_img, save_plot("fig/colonies_plot.png", colonies_plot), format = "file"),

  tar_target(bee_density_img, save_plot("fig/density_plot.png", bee_density), format = "file"),

  tar_target(correlation_honey_img, save_plot("fig/corr_plot.png", correlation_honey), format = "file"),

  ## Create a quarto document with the functions
  tar_quarto(
    name = my_doc,
    path = "my_doc.qmd"
  )


)

