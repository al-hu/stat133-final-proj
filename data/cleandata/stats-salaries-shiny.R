# setwd("/Users/apple/Documents/college/FALL 2016/stat 133/final/stat133-final-proj/data/cleandata")
# This is a Shiny web application. 
# It displays a horizontal bar-chart on team and salary statistic.

library(shiny)
library(ggplot2)
setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/data/cleandata")
# Define UI for application that draws a histogram
# setwd("/Users/apple/Documents/college/FALL 2016/stat 133/final/stat133-final-proj/data/cleandata")
# This is a Shiny web application. 
# It displays a horizontal bar-chart on team and salary statistic.


# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
    
    # Application title
    titlePanel("Stats and Salaries"),
    
    # Sidebar with 2 select widget inputs, one for different statistics and 
    # the other for displaying order 
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
                          "Salary...")),
            selectInput("yaxis",
                        "Statistic on Y-Axis",
                        c("Salary...",
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
                          value = FALSE
                          )
        ),
        
        # Show a horizontal bar-chart 
        mainPanel(
            plotOutput("scatterPlot"),
            textOutput("correlation")
        )
    )
))

# Define server logic required to draw a bar-chart
server <- shinyServer(function(input, output) {
    df <- read.csv("eff-stats-salary.csv")

    #toggle <- toString(input$colored)
    
    #cor(df$Points, df$Points)
    if (input$toggle) {
        output$scatterPlot <- renderPlot({
            ggplot(df, aes(x = get(toString(input$xaxis)),
                                            y = get(toString(input$yaxis)))) +
            geom_point(aes(col = df$Position)) +
            theme_minimal() +
            labs(x = input$xaxis, y = input$yaxis, col = "Position")
        })
    } else {
        output$scatterPlot <- renderPlot({
            ggplot(df, aes(x = get(toString(input$xaxis)),
                           y = get(toString(input$yaxis)))) +
                geom_point() +
                theme_minimal() +
                labs(x = input$xaxis, y = input$yaxis)
        })
    }

    x <- df[, toString(input$xaxis)]
    #y <- df[, toString(input$yaxis)]
    #coeff <- cor(x, y)
    #output$correlation <- renderText(paste0("Correlation Coefficient: ", as.character(coeff)))


})

ui1 <- fluidPage(
    checkboxInput("somevalue", "Some value", FALSE),
    verbatimTextOutput("value")
)
server1 <- function(input, output) {
    output$value <- renderText({ input$somevalue })
}
# Run the application 
#shinyApp(ui = ui1, server = server1)
shinyApp(ui = ui, server = server)







