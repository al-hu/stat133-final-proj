
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

finished_df <- data.frame()
for (i in team_names) {
    print(i)
    roster <- get_roster(i)
    salary <- get_salaries(i)
    stats <- get_stats(i)
    merged <- merge_team(roster, salary, stats)
    finished_df <- rbind(finished_df, merged)
}
finished_df <- finished_df[!duplicated(finished_df$Player), ]

View(finished_df)
