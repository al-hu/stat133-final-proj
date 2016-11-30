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
            checkboxInput("colored",
                          "Differentiate Positions by Colors"
                          )
        ),
        
        # Show a horizontal bar-chart 
        mainPanel(
            plotOutput("scatterPlot")
        )
    )
))

# Define server logic required to draw a bar-chart
server <- shinyServer(function(input, output) {
    

})


# Run the application 
shinyApp(ui = ui, server = server)







