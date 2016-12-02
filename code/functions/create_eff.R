# subset data for position 'PG' (point guard)
# and add Missed Field Goals MFG, Missed Free Throws MFT, Turnovers TO
# (these variables have negative sign)
subset_by_position <- function(position_name) {
    output <- dat %>%
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

# keep in mind that all variables are divided by number of games
calculate_matrix <- function(subset_name) {
    output <- as.matrix(subset_name[ ,stats] / 
                            subset_name$Games.Played)
    return(output)
}

# PCA with prcomp()
compute_pca <- function(matrix_name) {
    output <- prcomp(matrix_name, center = TRUE, scale. = TRUE)
    return(output)
}

compute_weights <- function(name_pca) {
    output <- abs(name_pca$rotation[,1])
    return(output)
}


# std deviations
calculate_sigmas <- function(matrix_name) {
    output <- apply(matrix_name, 2, sd)
    return(output)
}