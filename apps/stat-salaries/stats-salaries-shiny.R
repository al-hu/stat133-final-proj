# This is a Shiny web application. 
# It draws correlations between various statistics
# of the each basketball player.

library(shiny)
library(ggplot2)
setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj")

# Define UI for application that draws correlations between various statistics
# of the each basketball player.
# This is a Shiny web application. 
# It displays a scatterplot


# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
    
    # Application title
    titlePanel("Stats and Salaries"),
    p("Visualize the relationship between different game statistics."),
    
    # Sidebar with 2 select widget inputs, each to choose which statistic
    # to compare with the other
    # Supports coloring by position
    # Can create a linear regression line
    sidebarLayout(
        sidebarPanel(
            selectInput("xaxis",
                        "Statistic on X-Axis",
                        c("Points",
                          "Total.Rebounds",
                          "Assists",
                          "Steals",
                          "Blocks",
                          "Missed.Field.Goals",
                          "Missed.Free.Throws",
                          "Turnovers",
                          "Games.Played",
                          "Efficiency.Index",
                          "Salary")),
            selectInput("yaxis",
                        "Statistic on Y-Axis",
                        c("Salary",
                          "Points",
                          "Assists",
                          "Steals",
                          "Blocks",
                          "Missed.Field.Goals",
                          "Missed.Free.Throws",
                          "Turnovers",
                          "Games.Played",
                          "Efficiency.Index")),
            checkboxInput(inputId = "toggle",
                          label = "Differentiate Positions by Colors",
                          value = FALSE),
            checkboxInput("regress",
                          "Show Regression Line")
        ),
        
        # Show a horizontal bar-chart 
        mainPanel(
            plotOutput("scatterPlot"),
            textOutput("correlation")
        )
    )
))

# Define server logic required to make the Shiny app work
server <- shinyServer(function(input, output) {
    df <- reactive(read.csv("data/cleandata/eff-stats-salary.csv"))

    output$scatterPlot <- renderPlot({
      if (input$toggle) {
          if (input$regress) {
                ggplot(df(), aes(x = get(toString(input$xaxis)),
                               y = get(toString(input$yaxis)))) +
                geom_point(aes(col = df()$Position)) +
                geom_smooth(method=lm, se=FALSE) +
                theme_minimal() +
                labs(x = input$xaxis, y = input$yaxis, col = "Position")
              
          } else {
                ggplot(df(), aes(x = get(toString(input$xaxis)),
                                        y = get(toString(input$yaxis)))) +
                geom_point(aes(col = df()$Position)) +
                theme_minimal() +
                labs(x = input$xaxis, y = input$yaxis, col = "Position")
          }
          
      } else {
          if (input$regress) {
                ggplot(df(), aes(x = get(toString(input$xaxis)),
                               y = get(toString(input$yaxis)))) +
                geom_point() +
                geom_smooth(method=lm, se=FALSE) +
                theme_minimal() +
                labs(x = input$xaxis, y = input$yaxis)
          } else {
                ggplot(df(), aes(x = get(toString(input$xaxis)),
                           y = get(toString(input$yaxis)))) +
                geom_point() +
                theme_minimal() +
                labs(x = input$xaxis, y = input$yaxis)
          }

      }
    })
    
    output$correlation <- renderText({
        df <- read.csv("data/cleandata/eff-stats-salary.csv")
        x <- df[, input$xaxis]
        y <- df[, input$yaxis]
        coeff <- cor(x,y)
        paste0("Correlation Coefficient between ", input$xaxis, 
               " and ", input$yaxis, ": ", as.character(coeff))
        })

})

shinyApp(ui = ui, server = server)




