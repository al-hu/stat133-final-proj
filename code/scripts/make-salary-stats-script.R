# =========================================================================
# Title: Make salary-stat CSV for all the teams
#
# Description:
# This script contains R code to subset the salary statistics for all of the
# players in the NBA in the 2015-2016 season.  It loops through all of the 
# teams and and calculates the total payroll, minimum salary, maximum salary,
# first quartile salary, median salary, third quartile salary, average
# salary, the interquartile salary, and the standard deviation in salaries
# for each team, and then aggregates them into a final dataframe which is
# then written into a csv file.
# =========================================================================
setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/code/functions")

library(XML)
library(dplyr)
library(stringr)

# get vector of all teams
basketref <- 'http://www.basketball-reference.com'
url <- paste0(basketref, '/leagues/NBA_2016.html')
doc <- htmlParse(url)
team_rows <- getNodeSet(doc, "//th[@scope='row']/a")
team_hrefs <- xmlSApply(team_rows, xmlAttrs)
team_names <- substr(team_hrefs, 8, 10)
team_names <- team_names[1:30]

path_to_csv <- "../../data/cleandata/roster-salary-stats.csv"
df <- read.csv(path_to_csv)

# initialize vectors for the values needed to create dataframe
teams <- c()
total_payroll <- c()
min_salary <- c()
max_salary <- c()
first_quartile_salary <- c()
median_salary <- c()
third_quartile_salary <- c()
average_salary <- c()
interquartile_range <- c()
standard_deviation <- c()

# for each team, calculate the statistic and append it on
# to the already existing vector
for (i in team_names) {
    temp <- dplyr::filter(df, Team == i)
    total <- sum(temp$Salary...)
    smallest <- min(temp$Salary...)
    biggest <- max(temp$Salary...)
    first_quartile <- quantile(temp$Salary..., probs = 0.25)
    median <- quantile(temp$Salary..., probs = 0.50)
    third_quartile <- quantile(temp$Salary..., probs = 0.75)
    average <- mean(temp$Salary...)
    interquartile <- IQR(temp$Salary...)
    standard_dev <- sd(temp$Salary...)
    teams <- c(teams, i)
    total_payroll <- c(total_payroll, total)
    min_salary <- c(min_salary, smallest)
    max_salary <- c(max_salary, biggest)
    first_quartile_salary <- c(first_quartile_salary, first_quartile)
    median_salary <- c(median_salary, median)
    third_quartile_salary <- c(third_quartile_salary, third_quartile)
    average_salary <- c(average_salary, average)
    interquartile_range <- c(interquartile_range, interquartile)
    standard_deviation <- c(standard_deviation, standard_dev)
}

# combine all vectors together into a dataframe
aggregated <- data.frame(teams, total_payroll, min_salary, max_salary, 
           first_quartile_salary, median_salary, third_quartile_salary, 
           average_salary, interquartile_range, standard_deviation)

# write dataframe to csv file
root <- "/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj"
path_to_file <- "/data/cleandata/team-salaries.csv"
write.csv(aggregated, file = paste0(root, path_to_file))
