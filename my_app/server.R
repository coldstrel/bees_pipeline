server <- function(session, input, output) {

  filtered_data <- reactive(
    honey_data %>%
      filter(year %in% input$year_selected)
  )

  variable_selected <- eventReactive(input$render_plot, {
    input$variable_selected
  })

  ## Change the plot title according to user selection
  plot_title <- eventReactive(input$render_plot, {
    paste(variable_selected(), "for", paste(input$year_selected, collape = ", "))
  })

  ## ggplot

  output$bees_year_plot <- renderPlot({
    ggplot(data = filtered_data()) +
      theme_minimal() +
      geom_line(aes_string(variable_selected(), "colonies_number")) +
      labs(
        title = "Year plot by state"
      )
  })

  ## g2r plot
  output$bees_year_g2r <- renderG2({
    g2(data = filtered_data()) %>%
      fig_line(asp(!!rlang::sym(variable_selected(), year))) %>%
      subject(plot_title())
  })
}
