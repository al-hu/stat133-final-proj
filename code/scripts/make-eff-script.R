setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/code/functions")

library(XML)
library(dplyr)
library(stringr)

path_to_csv <- "../../data/cleandata/roster-salary-stats.csv"
df <- read.csv(path_to_csv)

vals <- dplyr::select(df, Player, Points, Total.Rebounds, Assists, Steals, 
                      Blocks, Field.Goals,Field.Goal.Attempts, Free.Throws, 
                      Free.Throw.Attempts, Turnovers, Games.Played, Salary...)

get_missed <- function(attempts, made) {
    return (attempts - made)
}



View(vals)
