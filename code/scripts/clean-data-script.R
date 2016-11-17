
setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/code/functions")

library(XML)

basketref <- 'http://www.basketball-reference.com'
url <- paste0(basketref, '/leagues/NBA_2016.html')
doc <- htmlParse(url)
team_rows <- getNodeSet(doc, "//th[@scope='row']/a")
team_hrefs <- xmlSApply(team_rows, xmlAttrs)
team_names <- substr(team_hrefs, 8, 10)

root <- "/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj"
source(file.path(root, "code/functions/merge_csvs.R"))

roster <- merge_roster(team_names)
View(roster)
salaries <- merge_salaries()
View(salaries)
stats <- merge_stats()
View(stats)
full_data <- merge_data(roster, salaries, stats)
View(full_data)

