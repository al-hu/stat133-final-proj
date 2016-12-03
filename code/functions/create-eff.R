# ============================================================================
# Title: Compute Efficiency Helper Functions
#
# Description: Helper functions to calculate efficiency of basketball players
# using Principal Components Analysis
# ============================================================================


# subset data for position 'PG' (point guard)
# and add Missed Field Goals MFG, Missed Free Throws MFT, Turnovers TO
# (these variables have negative sign)

# function that takes in dataframe such as roster-salary-stats.csv that has
# a column named Position and returns the rows of the input dataframe where
# the position is equal to the postiion name.  Also create the Missed Field 
# Goals MFG, Missed Free Throws MFT, Turnovers TO(these variables have 
# negative sign) and are to be used in calculating the efficiency index
# input1 - dataframe
# input2 - position name
# output - dataframe whose rows' Position value match the position name
subset_by_position <- function(df, position_name) {
    output <- df %>%
        filter(Position == position_name) %>%
        arrange(Player) %>%
        mutate(Missed.Free.Throws = Free.Throws - Free.Throw.Attempts) %>%
        mutate(Missed.Field.Goals = Field.Goals - Field.Goal.Attempts) %>%
        mutate(Turnovers = -1 * Turnovers)
    return(output)
}

# statistics required to calculate efficiency
stats <- c('Points', 'Total.Rebounds', 'Assists', 
           'Steals', 'Blocks', 'Missed.Free.Throws', 
           'Missed.Field.Goals', 'Turnovers')

# function that returns all variables that are in stats for the particular
# subset passed into the function.  Divides the stats by the number of
# games played for each player
# input - dataframe containing a subset of the roster-salary-stats data
# output - matrix that contains the values in stats 
# keep in mind that all variables are divided by number of games
calculate_matrix <- function(subset_name) {
    output <- as.matrix(subset_name[ ,stats] / 
                            subset_name$Games.Played)
    return(output)
}

# function that returns PCA using prcomp()
# input - matrix that contains numerical values
# output - a prcomp object using a mean of 0 and standard
# deviation of 1
compute_pca <- function(matrix_name) {
    output <- prcomp(matrix_name, center = TRUE, scale. = TRUE)
    return(output)
}

# function that returns the weights used for PCA
# input - a prcomp object
# output - vector of weights needed for PCA
compute_weights <- function(name_pca) {
    output <- abs(name_pca$rotation[,1])
    return(output)
}


# function that calculates the standard deviation for input matrix
# input - matrix that has numerical values
# output - vector of standard deviations for each input in the matrix
calculate_sigmas <- function(matrix_name) {
    output <- apply(matrix_name, 2, sd)
    return(output)
}