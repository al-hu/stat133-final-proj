# =========================================================================
# Title: Efficiency Index and PCA
#
# Description:
# This script shows you how to use Principal Component Analysis to
# compute the Efficiency Index for the final project using
# =========================================================================

library(dplyr)
library(ggplot2)
library(FactoMineR)
root <- "/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj"
setwd(root)

source(file.path(root, "code/functions/create_eff.R"))

# roster salary stats data
dat <- read.csv("data/cleandata/roster-salary-stats.csv", row.names = 1)

# subset the dataset by position
C <- subset_by_position('C')
PF <- subset_by_position('PF')
SF <- subset_by_position('SF')
SG <- subset_by_position('SG')
PG <- subset_by_position('PG')

# get the values required for calculating efficiency
matrix_C <- calculate_matrix(C)
matrix_PF <- calculate_matrix(PF)
matrix_SF <- calculate_matrix(SF)
matrix_SG <- calculate_matrix(SG)
matrix_PG <- calculate_matrix(PG)

# run the returned values through pca
C_pca <- compute_pca(matrix_C)
PF_pca <- compute_pca(matrix_PF)
SF_pca <- compute_pca(matrix_SF)
SG_pca <- compute_pca(matrix_SG)
PG_pca <- compute_pca(matrix_PG)

# get the weights for each player
C_weights <- compute_weights(C_pca)
PF_weights <- compute_weights(PF_pca)
SF_weights <- compute_weights(SF_pca)
SG_weights <- compute_weights(SG_pca)
PG_weights <- compute_weights(PG_pca)

# get the standard deviation for each player
C_sigmas <- calculate_sigmas(matrix_C)
PF_sigmas <- calculate_sigmas(matrix_PF)
SF_sigmas <- calculate_sigmas(matrix_SF)
SG_sigmas <- calculate_sigmas(matrix_SG)
PG_sigmas <- calculate_sigmas(matrix_PG)

# calculate modified eficiency, where we take the values
# and multiply them by the weights and divide by the 
# standard deviations
C_eff <- matrix_C %*% (C_weights / C_sigmas)
PF_eff <- matrix_PF %*% (PF_weights / PF_sigmas)
SF_eff <- matrix_SF %*% (SF_weights / SF_sigmas)
SG_eff <- matrix_SG %*% (SG_weights / SG_sigmas)
PG_eff <- matrix_PG %*% (PG_weights / PG_sigmas)

# add efficiency index to our dataframe
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

eff_stats_salary <- rename(eff_stats_salary, Salary = Salary...)


# write csv file and save it to a specific folder
path_to_file <- "/data/cleandata/eff-stats-salary.csv"
write.csv(eff_stats_salary, file = paste0(root, path_to_file))
