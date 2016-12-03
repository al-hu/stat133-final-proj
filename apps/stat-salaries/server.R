

library(shiny)
library(ggplot2)
setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj")

# Define server logic required to make the Shiny app work
shiny::shinyServer(function(input, output) {
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