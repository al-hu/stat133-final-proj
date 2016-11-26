new_colname <- c("Player",
                 "Number", "Position", 
                 "Height(in)", "Weight(lbs)", 
                 "Birth Date", "Country", 
                 "Years Experience", "College", 
                 "Team", "Salary($)", "Age", 
                 "Games Played", "Games Started", 
                 "Minutes Played", "Field Goals", 
                 "Field Goal Attempts", 
                 "Field Goal Percentage", 
                 "Three Point Goals", 
                 "Three Point Field Goal Attempts", 
                 "Three Point Field Goal Percentage", 
                 "Two Point Field Goals", 
                 "Two Point Field Goal Attempts", 
                 "Two Point Field Goal Percentage",
                 "Effective Field Goal Percentage", 
                 "Free Throws", "Free Throw Attempts", 
                 "Free Throw Percentage", 
                 "Offensive Rebounds", 
                 "Defensive Rebounds", "Total Rebounds", 
                 "Assists", "Steals", "Blocks", 
                 "Turnovers", "Personal Fouls", "Points")

change_colname <- function(df, names) {
    output <- setNames(df, names)
    return(output)
}

clean_salary <- function(df) {
    to_strip <- df$`Salary($)`
    stripped <- gsub("\\$", "", to_strip)
    df$`Salary($)` <- stripped
    return(df)
}

upper_country <- function(df) {
    to_change <- df$Country
    upper_cased <- as.factor(toupper(to_change))
    df$Country <- upper_cased
    return(df)
}

clean_positions <- function(df) {
    to_filter <- df$Position
    output <- filter(df, grepl("C|PF|SF|SG|PG", to_filter))
    return(output)
}


convert_salaries_to_numeric <- function(df) {
    salaries <- df$`Salary($)`
    changed <- gsub("\\,", "", salaries)
    df$`Salary($)` <- as.numeric(changed)
    return(df)
}

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

convert_number_to_factor <- function(df) {
    factorized <- as.factor(df$Number)
    df$Number <- factorized
    return(df)
}

convert_years_to_nums <- function(df) {
    to_convert <- df$`Years Experience`
    converted <- stringr::str_replace_all(to_convert, "R", "0")
    num_version <- as.numeric(converted)
    df$`Years Experience` <- num_version
    return(df)
}
