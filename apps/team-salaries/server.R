# Define server logic required to draw a bar-chart

library(shiny)
library(ggplot2)
setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj")

shiny::shinyServer(function(input, output) {
    
    df <- read.csv(file = "data/cleandata/team-salaries.csv")
    
    output$barPlot <- renderPlot({
        
        if (input$order == "Ascending") {
            ggplot(df, aes(x = reorder(teams, get(toString(input$statistic))),
                           y = get(toString(input$statistic)), fill = teams)) +
                geom_bar(stat = "identity") +
                coord_flip() +
                theme_minimal() +
                ylab(input$statistic) +
                xlab("teams") +
                ggtitle("Bar-chart for Team-Salaries")}
        else {
            ggplot(df, aes(x = reorder(teams, -get(toString(input$statistic))),
                           y = get(toString(input$statistic)), fill = teams)) +
                geom_bar(stat = "identity") +
                coord_flip() +
                theme_minimal() +
                ylab(input$statistic) +
                xlab("teams") +
                ggtitle("Bar-chart for Team-Salaries")}  
    })
})



