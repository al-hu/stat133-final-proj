# ============================================================================
# Title: Clean Data Helper Functions
#
# Description: Helper functions to clean data pulled from Basketball Reference
# ============================================================================

# establish the column names of the resulting dataframe
new_colname <- c("Player",
                 "Number", "Position", 
                 "Height(in)", "Weight(lbs)", 
                 "Birth.Date", "Country", 
                 "Years.Experience", "College", 
                 "Team", "Salary($)", "Age", 
                 "Games.Played", "Games.Started", 
                 "Minutes.Played", "Field.Goals", 
                 "Field.Goal.Attempts", 
                 "Field.Goal.Percentage", 
                 "Three.Point.Goals", 
                 "Three.Point.Field.Goal.Attempts", 
                 "Three.Point.Field.Goal.Percentage", 
                 "Two.Point.Field.Goals", 
                 "Two.Point.Field.Goal.Attempts", 
                 "Two.Point.Field.Goal.Percentage",
                 "Effective.Field.Goal.Percentage", 
                 "Free.Throws", "Free.Throw.Attempts", 
                 "Free.Throw.Percentage", 
                 "Offensive.Rebounds", 
                 "Defensive.Rebounds", "Total.Rebounds", 
                 "Assists", "Steals", "Blocks", 
                 "Turnovers", "Personal.Fouls", "Points")

# function that reads a dataframe, and returns a dataframe 
# with new_colname as the new column names
# input - merged dataframe containing roster, salary, and stats data
# output - merged dataframe containing roster, salary, and stats data
# and new_colname as the names of the columns
change_colname <- function(df, names) {
    output <- setNames(df, names)
    return(output)
}

# function that reads a dataframe with a column named Salary($), and 
# strips the $ from all the values in Salary($)
# input - merged dataframe containing roster, salary, and stats data
# output - merged dataframe containing roster, salary, and stats data
# with values in Salary($) column no longer have $.
clean_salary <- function(df) {
    to_strip <- df$`Salary($)`
    stripped <- gsub("\\$", "", to_strip)
    df$`Salary($)` <- stripped
    return(df)
}

# function that reads a dataframe with a column named Country and
# capitalizes all the values in that column
# input - merged dataframe containing roster, salary, and stats data
# output - merged dataframe containing roster, salary, and stats data
# with capitalized values in the Country column.
upper_country <- function(df) {
    to_change <- df$Country
    upper_cased <- as.factor(toupper(to_change))
    df$Country <- upper_cased
    return(df)
}

# function that reads a dataframe with a column named Position and
# gets rid of all rows that don't have 'C', 'PF', 'SF', 'SG', or 'PG'.
# input - merged dataframe containing roster, salary, and stats data
# output - merged dataframe containing roster, salary, and stats data with 
# rows that only have 'C', 'PF', 'SF', 'SG', or 'PG' in their Position column
clean_positions <- function(df) {
    to_filter <- df$Position
    output <- filter(df, grepl("C|PF|SF|SG|PG", to_filter))
    return(output)
}

# function that reads a dataframe with a column named Salary($), and 
# turns the values in that column into mode numeric.
# input - merged dataframe containing roster, salary, and stats data
# output - merged dataframe containing roster, salary, and stats data
# with values in Salary($) column as numeric values
convert_salaries_to_numeric <- function(df) {
    salaries <- df$`Salary($)`
    changed <- gsub("\\,", "", salaries)
    df$`Salary($)` <- as.numeric(changed)
    return(df)
}


# function that reads a dataframe with a column named Height(in), and 
# turns the values that are originally in the form of Feet-Inches into
# values that are just in inches.
# input - merged dataframe containing roster, salary, and stats data
# output - merged dataframe containing roster, salary, and stats data
# with values in the Height(in) column measured in inches.
convert_height_to_inches <- function(df) {
    heights <- df$`Height(in)`
    split <- stringr::str_split(heights, "\\-")
    height_vector <- c()
    for (i in 1:length(split)) {
        feet <- as.numeric(split[[i]][1])
        feet_in_inches <- feet * 12
        inches <- as.numeric(split[[i]][2])
        sum <- feet_in_inches + inches
        height_vector <- c(height_vector, sum)
    }
    df$`Height(in)` <- height_vector
    return(df)
}

# function that reads a dataframe with a column named Years.Experience,
# and converts them into a numeric column
# input - merged dataframe containing roster, salary, and stats data
# output - merged dataframe containing roster, salary, and stats data
# with values in Years.Experience as mode numeric.
convert_years_to_nums <- function(df) {
    to_convert <- df$`Years.Experience`
    converted <- stringr::str_replace_all(to_convert, "R", "0")
    num_version <- as.numeric(converted)
    df$`Years.Experience` <- num_version
    return(df)
}