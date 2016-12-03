library(shiny)
library(ggplot2)
setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj")

# Define UI for application that draws correlations between various statistics
# of the each basketball player.
# This is a Shiny web application. 
# It displays a scatterplot between any two of the columns in the 
# eff-stats-salary.csv


# Define UI for application that draws a scatterplot
shiny::shinyUI(fluidPage(
    
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