get_data <- function(){
  myProject::honey_data
}


## plot number of bees colonies on a specific year
make_plot <- function(data, year){
  data %>%
    filter(year == !!year) %>%
    ggplot(aes(x=reorder(state, colonies_number), y = colonies_number)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    labs(
      title = paste("Number of Colonies by State in", year),
      x = "State",
      y = "Number of Colonies"
    ) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
}


## plot densities over the year on specific state
plot_bee_density <- function(data, state) {
  data %>%
    filter(state == !!state) %>%
    ggplot(aes(x = year, y = colonies_number)) +
    geom_line(color = "steelblue", size = 1) +
    geom_point(color = "red") +
    labs(
      title = paste("Number of Colonies in", state, "Over the Years"),
      x = "Year",
      y = "Number of Colonies"
    ) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

## Plot correlation between two given columns
corr_bees <- function(data, col1, col2) {
  # Apply log transformation to the columns (handling zero values by adding 1)
  data <- data %>%
    mutate(
      log_col1 = log(get(col1) + 1),
      log_col2 = log(get(col2) + 1)
    )

  # Calculate the correlation coefficient between the log-transformed columns
  correlation <- cor(data$log_col1, data$log_col2, use = "complete.obs")

  # Create the scatter plot with log-transformed values
  ggplot(data, aes(x = log_col1, y = log_col2)) +
    geom_point(color = "blue", alpha = 0.5) +  # Scatter plot of log-transformed values
    geom_smooth(method = "lm", se = FALSE, color = "red") +  # Linear regression line
    labs(
      title = paste("Correlation between", col1, "and", col2,
                    "\nCorrelation Coefficient: ", round(correlation, 2)),
      x = paste("Log of", col1),
      y = paste("Log of", col2)
    )
}


## Save the created plots
save_plot <- function(save_path, plot){
  ggsave(save_path, plot)
  save_path
}










