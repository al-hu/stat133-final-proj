setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/code/functions")

library(XML)
library(dplyr)
library(stringr)

basketref <- 'http://www.basketball-reference.com'
url <- paste0(basketref, '/leagues/NBA_2016.html')
doc <- htmlParse(url)
team_rows <- getNodeSet(doc, "//th[@scope='row']/a")
team_hrefs <- xmlSApply(team_rows, xmlAttrs)
team_names <- substr(team_hrefs, 8, 10)
team_names <- team_names[1:30]

root <- "/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj"

source(file.path(root, "code/functions/merge_csvs.R"))
source(file.path(root, "code/functions/clean_data.R"))

finished_df <- data.frame()
for (i in team_names) {
    roster <- get_roster(i)
    salary <- get_salaries(i)
    stats <- get_stats(i)
    merged <- merge_team(roster, salary, stats)
    finished_df <- rbind(finished_df, merged)
}
finished_df <- finished_df[!duplicated(finished_df$Player), ]
finished_df <- change_colname(finished_df, new_colname)
finished_df <- clean_salary(finished_df)
finished_df <- upper_country(finished_df)
finished_df <- clean_positions(finished_df)
finished_df <- convert_salaries_to_numeric(finished_df)
finished_df <- convert_height_to_inches(finished_df)
finished_df <- convert_years_to_nums(finished_df)

path_to_file <- "/data/cleandata/roster-salary-stats.csv"
write.csv(finished_df, file = paste0(root, path_to_file))
