# =========================================================================
# Title: Clean Data Scraped from Internet
#
# Description:
# This script contains R code to assemble the full dataset for all of the
# players in the NBA in the 2015-2016 season.  For each of the teams in
# the NBA, their roster, salary, and stats dataframes are read in from csv
# files previously scraped from the internet.  They are then merged together
# and after creating the amalgamated values for each of the dataframes,
# they are all put together into a final dataframe, which is then saved
# in roster-salary-stats.csv.
# =========================================================================
root <- "/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj"
setwd(root)

library(XML)
library(dplyr)
library(stringr)

# get all a list of all the team names
basketref <- 'http://www.basketball-reference.com'
url <- paste0(basketref, '/leagues/NBA_2016.html')
doc <- htmlParse(url)
team_rows <- getNodeSet(doc, "//th[@scope='row']/a")
team_hrefs <- xmlSApply(team_rows, xmlAttrs)
team_names <- substr(team_hrefs, 8, 10)
team_names <- team_names[1:30]

# load functions that help with merging / cleaning our data
source(file.path(root, "code/functions/merge_csvs.R"))
source(file.path(root, "code/functions/clean_data.R"))

# iterate through each team and get their roster, salary, and stats tables.
# then merge them together and add them to a dataframe that contains
# all the data
finished_df <- data.frame()
for (i in team_names) {
    roster <- get_roster(i)
    salary <- get_salaries(i)
    stats <- get_stats(i)
    merged <- merge_team(roster, salary, stats)
    finished_df <- rbind(finished_df, merged)
}
# get rid of any duplicates
finished_df <- finished_df[!duplicated(finished_df$Player), ]

# change column names to be more informative
finished_df <- change_colname(finished_df, new_colname)

# get rid of dollar sign from all salaries
finished_df <- clean_salary(finished_df)

# convert cleaned salary column into type numeric
finished_df <- convert_salaries_to_numeric(finished_df)

# capitalize country that the players come from
finished_df <- upper_country(finished_df)

# get rid of any players that dont have C, PF, PG, SG, or SF as their position
finished_df <- clean_positions(finished_df)

# convert height into standard unit of inches
finished_df <- convert_height_to_inches(finished_df)

# convert years from a factor into mode numeric
finished_df <- convert_years_to_nums(finished_df)

# convert birth dates from factor into date objects
finished_df$Birth.Date <- as.Date(finished_df$Birth.Date, "%B %d, %Y")

#write resulting cleaned dataframe to CSV
path_to_file <- "/data/cleandata/roster-salary-stats.csv"
write.csv(finished_df, file = paste0(root, path_to_file))
