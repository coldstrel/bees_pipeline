ui <- function(request) {
  fluidPage(
    titlePanel("Honey bees production in USA"),

    sidebarLayout(
      sidebarPanel(
        selectizeInput("year_selected", "Select a year:",
                       choices = unique(honey_data$year),
                       multiple = TRUE,
                       selected = c(1995),
                       options = list(
                         plugins = list("remove_button"),
                         create = TRUE,
                         persist = FALSE
                       )
        ),
        hr(),

        ## Select a varible by the user
        selectInput("varible_selected", "Select vairble to plot:",
                    choices = setdiff(unique(colnames(honey_data)), c("year","state")),
                    multiple = FALSE,
                    selected = "year",
                    ),
        hr(),

        actionButton(inputId = "render_plot",
                     label = " Click here to generate plot"),

        hr(),

        helpText("Data from Kaggle"),

      ),

      mainPanel(
        tabsetPanel(

           tabPanel("ggplot verision", plotOutput("bees_year_plot")),
          tabPanel("g2r version", g2Output("bees_year_g2r"))

      )
    )
  )
  )
}
