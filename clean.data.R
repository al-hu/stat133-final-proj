
setwd("/Users/Nicole/Desktop")

library(dplyr)

# read csv file and convert all blank cells to 'NA' values
unclean_df <- read.csv(file = "unclean.csv", 
                       stringsAsFactors = FALSE, 
                       na.strings = c('', 'NA'))

# function: change column names
# function that change the column name of a dataframe to the input value
# so that the variable names are not abbreviated, and return the dataframe
# with new column names
# input - vector with new column name (not abbreviated ones)
# output - the dataframe with new column names

new_colname <- c("X","Player",
                  "Number", "Position", 
                  "Height(ft-in)", "Weight(lbs)", 
                  "Birth-Date", "Country", 
                  "Years-Experience", "College", 
                  "Team", "Salary($)", "Age", 
                  "Games", "Games-Started", 
                  "Min-Played", "Field-Goals", 
                  "Field-Goal-Att", 
                  "Field-Goal-Pct", 
                  "Three-Point-Goals", 
                  "Three-Point-Att", 
                  "Three-Point-Pct", 
                  "Two-Point-Goals", 
                  "Two-Point-Att", 
                  "Two-Point-Pct", 
                  "Effective-Field-Goal-Pct", 
                  "Free-Throws", "Free-Throw-Att", 
                  "Free-Throw-Pct", 
                  "Offensive-Rebounds", 
                  "Defensive-Rebounds", "Total-Rebounds", 
                  "Assists", "Steals", "Blocks", 
                  "Turnovers", "Personal-Fouls", "Points")

change_colname <- function(col_name) {
  output <- setNames(unclean_df, col_name)
  return(output)
}

new_colname_df <- change_colname(new_colname)

# function: remove dollar signs in 'Salary' column
reformat_Salary <- function(col_name) {
  output <- gsub("\\$", "", col_name)
  return(output)
}

Salary <- reformat_Salary(new_colname_df$Salary)
Salary

# function: convert the values in column 'X.' to capital letters 
# (don't know if we really need this function)
reformat_country <- function(col_name) {
  output <- toupper(col_name)
  return(output)
}

Country <- reformat_country(new_colname_df$Country)
Country

# Replace two columns in 'new_colname_df'
new_colname_df$`Salary($)` <- Salary
new_colname_df$Country <- Country

# function: extract rows that have certain values in column 'Pos'
extract_position <- function(col_name) {
  output <- filter(new_colname_df, grepl("C|PF|SF|SG|PG", col_name))
  return(output)
}

clean_df <- extract_position(new_colname_df$Position)
View(clean_df)
