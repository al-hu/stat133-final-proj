# =========================================================================
# Title: Efficiency Index and PCA
#
# Description:
# This script shows you how to use Principal Component Analysis to
# compute the Efficiency Index for the final project using
# the "dummy" data (season 2014-2015)
# 
# Details:
# The code focuses on players who are PG "Point Guards"
# PG runs the team's offense by controlling the ball and making 
# sure that it gets to the right players at the right time.
# =========================================================================

library(dplyr)
library(ggplot2)
library(FactoMineR)

setwd("/Users/Nicole/Desktop/stat133-final-proj")

# data from github repository
dat <- read.csv("data/cleandata/roster-salary-stats.csv",
                row.names = 1,
                stringsAsFactors = FALSE)

# =========================================================================
# Efficiency
# =========================================================================

# subset data for position 'PG' (point guard)
# and add Missed Field Goals MFG, Missed Free Throws MFT, Turnovers TO
# (these variables have negative sign)
subset_by_position <- function(position_name) {
  output <- dat %>%
    filter(Position == position_name) %>%
    mutate(Missed.Free.Throws = Free.Throws - Free.Throw.Attempts) %>%
    mutate(Missed.Field.Goals = Field.Goals - Field.Goal.Attempts) %>%
    mutate(Turnovers = -1 * Turnovers)
  return(output)
}

C <- subset_by_position('C')
PF <- subset_by_position('PF')
SF <- subset_by_position('SF')
SG <- subset_by_position('SG')
PG <- subset_by_position('PG')

# statistics for efficiency
stats <- c('Points', 'Total.Rebounds', 'Assists', 
           'Steals', 'Blocks', 'Missed.Free.Throws', 
           'Missed.Field.Goals', 'Turnovers')

# keep in mind that all variables are divided by number of games
calculate_matrix <- function(subset_name) {
  output <- as.matrix(subset_name[ ,stats] / 
                      subset_name$Games.Played)
  return(output)
}

matrix_C <- calculate_matrix(C)
matrix_PF <- calculate_matrix(PF)
matrix_SF <- calculate_matrix(SF)
matrix_SG <- calculate_matrix(SG)
matrix_PG <- calculate_matrix(PG)

# PCA with prcomp()
compute_pca <- function(matrix_name) {
  output <- prcomp(matrix_name, center = TRUE, scale. = TRUE)
  return(output)
}

C_pca <- compute_pca(matrix_C)
PF_pca <- compute_pca(matrix_PF)
SF_pca <- compute_pca(matrix_SF)
SG_pca <- compute_pca(matrix_SG)
PG_pca <- compute_pca(matrix_PG)

compute_weights <- function(name_pca) {
  output <- abs(name_pca$rotation[,1])
  return(output)
}

C_weights <- compute_weights(C_pca)
PF_weights <- compute_weights(PF_pca)
SF_weights <- compute_weights(SF_pca)
SG_weights <- compute_weights(SG_pca)
PG_weights <- compute_weights(PG_pca)

# std deviations
calculate_sigmas <- function(matrix_name) {
  output <- apply(matrix_name, 2, sd)
  return(output)
}

C_sigmas <- calculate_sigmas(matrix_C)
PF_sigmas <- calculate_sigmas(matrix_PF)
SF_sigmas <- calculate_sigmas(matrix_SF)
SG_sigmas <- calculate_sigmas(matrix_SG)
PG_sigmas <- calculate_sigmas(matrix_PG)

View(SG_sigmas)
# modified efficiency
C_eff <- matrix_C %*% (C_weights / C_sigmas)
PF_eff <- matrix_PF %*% (PF_weights / PF_sigmas)
SF_eff <- matrix_SF %*% (SF_weights / SF_sigmas)
SG_eff <- matrix_SG %*% (SG_weights / SG_sigmas)
PG_eff <- matrix_PG %*% (PG_weights / PG_sigmas)

C$Efficiency.Index <- C_eff
PF$Efficiency.Index <- PF_eff
SF$Efficiency.Index <- SF_eff
SG$Efficiency.Index <- SG_eff
PG$Efficiency.Index <- PG_eff

# merge dataframes of five different positions
merged_eff_df <- Reduce(function(x, y) merge(x, y, all=TRUE), 
                       list(C, PF, SF, SG, PG))

# create a dataframe containing selected 12 variables
eff_stats_salary <- select(merged_eff_df, 
                           Player, Position, Points, 
                           Total.Rebounds, Assists, 
                           Steals, Blocks, 
                           Missed.Field.Goals,
                           Missed.Free.Throws, 
                           Turnovers, 
                           Games.Played,
                           Efficiency.Index,Salary...)

eff_stats_salary$Missed.Field.Goals <- abs(eff_stats_salary$
                                             Missed.Field.Goals)
eff_stats_salary$Missed.Free.Throws <- abs(eff_stats_salary$
                                             Missed.Free.Throws)
eff_stats_salary$Turnovers <- abs(eff_stats_salary$
                                    Turnovers)

# write csv file and save it to a specific folder
root <- "/Users/Nicole/Desktop/stat133-final-proj"
path_to_file <- "/data/cleandata/eff-stats-salary.csv"
write.csv(eff_stats_salary, file = paste0(root, path_to_file))