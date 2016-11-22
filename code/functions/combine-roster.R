library(XML)
basketref <- 'http://www.basketball-reference.com'
url <- paste0(basketref, '/leagues/NBA_2016.html')
doc <- htmlParse(url)
team_rows <- getNodeSet(doc, "//th[@scope='row']/a")
team_hrefs <- xmlSApply(team_rows, xmlAttrs)
team_names <- substr(team_hrefs, 8, 10)
team_names

base_path <- "../../data/rawdata/roster-data/roster-"
test <- read.csv(paste0(base_path, team_names[2], '.csv'))
test
nrow(test)
setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/code/functions")

finished_df <- data.frame()

for (i in team_names) {
    to_add <- read.csv(paste0(base_path, i, '.csv'))
    to_add$Team <- rep(i, nrow(to_add))
    finished_df <- rbind(finished_df, to_add)
}

View(finished_df)

