
setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/code/functions")


# merge table for each team, then stack, then use duplicates to get rid of duplicates
library(XML)

basketref <- 'http://www.basketball-reference.com'
url <- paste0(basketref, '/leagues/NBA_2016.html')
doc <- htmlParse(url)
team_rows <- getNodeSet(doc, "//th[@scope='row']/a")
team_hrefs <- xmlSApply(team_rows, xmlAttrs)
team_names <- substr(team_hrefs, 8, 10)
team_names <- team_names[1:30]
length(team_names)
root <- "/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj"
source(file.path(root, "code/functions/merge_csvs.R"))


# can use duplicated to get rid of players that have been part of multiple teams
# XX[!duplicated(XX$ID]  <- this gets rid of 
roster <- merge_roster(team_names)
View(roster)
salaries <- merge_salaries()
View(salaries)
stats <- merge_stats()
View(stats)
full_data <- merge_data(roster, salaries, stats)
View(full_data)
full_data <- full_data[!duplicated(full_data$Player), ]
View(full_data)









library(dplyr)
mydata1 <- roster[, 2:11]
mydata2 <- salaries[, 3:4]
mydata3 <- stats[, 3:17]
partialdata <- inner_join(mydata1, mydata2, by = "Player")
View(partialdata)
myfulldata <- inner_join(partialdata, mydata3, by = "Player")
View(myfulldata)
