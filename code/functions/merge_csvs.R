library(XML)
basketref <- 'http://www.basketball-reference.com'
url <- paste0(basketref, '/leagues/NBA_2016.html')
doc <- htmlParse(url)
team_rows <- getNodeSet(doc, "//th[@scope='row']/a")
team_hrefs <- xmlSApply(team_rows, xmlAttrs)
team_names <- substr(team_hrefs, 8, 10)



setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/code/functions")

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
    View(myfulldata)
    return(myfulldata)
}

#EVERYTHING BELOW IS NOT TO BE USED
merge_roster <- function (team_names) {
    finished_df <- data.frame()
    base_path <- "../../data/rawdata/roster-data/roster-"
    
    for (i in team_names) {
        to_add <- read.csv(paste0(base_path, i, '.csv'))
        to_add$Team <- rep(i, nrow(to_add))
        finished_df <- rbind(finished_df, to_add)
    }
    finished_df <- finished_df[!duplicate(finished_df$Player), ]
    return(finished_df)
}


# test if rbind() works in the situation of only merging first two dataframes
#setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/code/functions")

merge_stats <- function () {
    file_path <- "../../data/rawdata/stat-data/"
    files <- list.files(path = file_path, pattern = "*.csv")
    files
    myfiles = do.call(rbind, lapply(files, function(x) {
        read.csv(paste0(file_path, x), stringsAsFactors = FALSE)
    }))
    myfiles <- myfiles[!duplicate(myfiles$Player), ]
    return(myfiles)
}


merge_salaries <- function () {
    file_path <- "../../data/rawdata/salary-data/"
    files <- list.files(path = file_path, pattern = "*.csv")
    files
    myfiles = do.call(rbind, lapply(files, function(x) {
        read.csv(paste0(file_path, x), stringsAsFactors = FALSE)
    }))
    myfiles <- myfiles[!duplicate(myfiles$Player), ]
    
    return(myfiles)
}

# function that merges three dataframes together, based on column "Player"
# input 1 - dataframe that contains the rosters of all teams
# input 2 - dataframe that contains the salaries of each player
# input 3 - dataframe that contains the stats of each player
# output - dataframe that has the salary and stats of each player in the NBA

merge_data <- function(df1, df2, df3) {
    mydata1 <- df1[, 2:11]
    mydata2 <- df2[, 3:4]
    mydata3 <- df3[, 3:17]
    partialdata <- merge(mydata1, mydata2, by = "Player")
    myfulldata <- merge(partialdata, mydata3, by = "Player")
    return(myfulldata)
}
