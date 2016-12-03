# This is a Shiny web application. 
# It displays a horizontal bar-chart on team and salary statistic.

library(shiny)
library(ggplot2)
setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj")

# Define UI for application that draws a histogram
shiny::shinyUI(fluidPage(
    
    # Application title
    titlePanel("Team Salaries"),
    p("Display salary statistics for each team."),
    
    # Sidebar with 2 select widget inputs, one for different statistics and 
    # the other for displaying order 
    sidebarLayout(
        sidebarPanel(
            selectInput("statistic",
                        "Desired Salary Statistic",
                        c("total_payroll",
                          "min_salary",
                          "max_salary",
                          "first_quartile_salary",
                          "median_salary",
                          "third_quartile_salary",
                          "average_salary",
                          "interquartile_range",
                          "standard_deviation")),
            selectInput("order",
                        "Displaying Order",
                        c("Ascending",
                          "Descending"))
        ),
        
        # Show a horizontal bar-chart 
        mainPanel(
            plotOutput("barPlot")
        )
    )
))
