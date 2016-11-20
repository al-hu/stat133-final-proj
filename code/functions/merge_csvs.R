
#setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/code/functions")

# function that reads a roster csv, and returns at dataframe 
# with the team name appended to each row of the csv
# input - team name abbreviation (e.g. "CLE")
# output - dataframe containing data in the team's roster csv
get_roster <- function(team_name) {
    base_path <- "../../data/rawdata/roster-data/roster-"
    df <- read.csv(paste0(base_path, team_name, ".csv"))
    df$Team <- rep(team_name, nrow(df))
    return(df)
}

# function that reads a stats csv, returns a dataframe of the csv
# input - team name abbreviation (e.g. "CLE")
# output - dataframe containing data in the team's stats csv
get_stats <- function(team_name) {
    base_path <- "../../data/rawdata/stat-data/stats-"
    df <- read.csv(paste0(base_path, team_name, ".csv"))
    return(df)
}

# function that reads a salaries csv, returns a dataframe of the csv
# input - team name abbreviation (e.g. "CLE")
# output - dataframe containing data in the team's salaries csv
get_salaries <- function(team_name) {
    base_path <- "../../data/rawdata/salary-data/salaries-"
    df <- read.csv(paste0(base_path, team_name, ".csv"))
    return(df)
}

# function that merges roster, salaries, and stats dataframes together
# for a certain team (assumes dataframes are for the same team)
# input1 - dataframe read in from a team's roster csv (contains roster data)
# input2 - dataframe read in from a team's salaries csv (contains salary data)
# input3 - dataframe read in from a team's stats csv (contains stats data)
merge_team <- function(roster, salaries, stats) {
    roster_df <- roster[, 2:11]
    salaries_df <- salaries[, 3:4]
    stats_df <- stats[, 3:29]
    partialdata <- merge(roster_df, salaries_df, by = "Player")
    myfulldata <- merge(partialdata, stats_df, by = "Player")
    return(myfulldata)
}