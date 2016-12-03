# This is a Shiny web application. 
# It displays a horizontal bar-chart on team and salary statistic.

library(shiny)
library(ggplot2)
setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj")

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
   
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

# Define server logic required to draw a bar-chart
server <- shinyServer(function(input, output) {
  
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


# Run the application 
shinyApp(ui = ui, server = server)



