# =========================================================================
# Title: Best and Worst Valued Player

# Description:
# This script selectes the top 20 player with highest values
# and 20 worst player with lowest value

# Details:
# The code calculates values using formula 
# value = efficiency / salary for each player and
# use package dplyr to arranges players by their values in asceding order.
# Then use package dplyr to extract the top 20 player with highest values
# and 20 worst player with lowest value
# =========================================================================


library(dplyr)
getwd()
setwd("stat133-final-proj/data/cleandata")
eff_stats_salary <- read.csv("eff-stats-salary.csv", 
                             row.names = 1, stringsAsFactors = FALSE)

# =========================================================================
#Calculate value for each player
# =========================================================================

#calculate value for each player using the formula 
#value = efficiency / salary
eff_stats_salary$Value <- eff_stats_salary$Efficiency.Index / 
  eff_stats_salary$Salary  


# =========================================================================
#Sort players by their values in asceding order
# =========================================================================

#create a data frame of players and their values
valuedf <- subset(eff_stats_salary, select = c("Player", "Value"))
View(valuedf)
#reorder the data frame by values in ascending order
Order.Value.df <- arrange(valuedf, Value)
View(Order.Value.df)

# =========================================================================
#Select top 20 player with highest values 
#and 20 worst player with lowest value
# =========================================================================

#create a data frame for the best players
Best.Value.Players <- slice(Order.Value.df, 471:452)

#create a data frame for the worst players
Worst.Value.Players <- slice(Order.Value.df, 1:20)

#create a data frame by combining the two data frame
Best.Worst.Players <- cbind(Best.Value.Players, Worst.Value.Players)

#change column names
names(Best.Worst.Players)[1] <- paste("Best.Player")
names(Best.Worst.Players)[3] <- paste("Worst.Player")

#remove value columns
Best.Worst.Value.Players <- Best.Worst.Players[, c(1,3)]
View(Best.Worst.Players)

#create txt file for the best and worst 20 players
sink(file = 'Best.Worst.Value.Players.txt', append = TRUE)

