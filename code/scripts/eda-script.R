# =========================================================================
# Title: Exploratory Data Analysis
#
# Description:
# This script shows you the exploratory phase. This phase comprises
# analyzing one varaible at a time calculating summary statistics
# for all variables. Also, this script produces related graphs for 
# better analyzing data.
# 
# Details:
# The code focuses on performing exploratory analysis.
# The scatterplot section helps analyze correlation between some
# variables.
# =========================================================================

setwd("/Users/Nicole/Desktop/stat133-final-proj/data/cleandata")

library(ggplot2)
library(scales)

# data from repository
roster_salary_stats <- read.csv("roster-salary-stats.csv")

# convert column 'Number' to factor in order to compute the freq 
# for each number
factorized <- as.factor(roster_salary_stats$Number)
roster_salary_stats$Number <- factorized

# convert column 'Birth.Date' to date format
date_format <- as.Date(roster_salary_stats$Birth.Date)
roster_salary_stats$Birth.Date <- date_format

# =========================================================================
# Calculate summary statistics for variables
# =========================================================================

# calculate summary statistics to each variable excluding 
# the first column
lapply(roster_salary_stats[2:38], summary)

# redirect output to 'cleandata' directory
sink(file = 'eda-output.txt', append = TRUE)

# =========================================================================
# Produce barcharts, box-plots and histograms
# =========================================================================

# extract a dataframe called 'qual_df' containing only 
# qualitative variables
qual_df <- Filter(is.factor, roster_salary_stats[3:38]) 

# extract the column names of qualitative variables
qual_colnames <- names(qual_df)

# loop over each qualitative variable to produce multiple barcharts
# and save them as separate pdf files
for(i in qual_colnames) {
  # produce multiple pdf files in specific file names
  pdf(paste("../../images/", i, "_barchart.pdf", sep = ""))
  # plot barcharts with x axis as names of the qualitative
  # variables
  barcharts <- ggplot(roster_salary_stats,
                      aes_string(x = i)) +
                 geom_bar() +
                 # add titles and change axis labels
                 labs(title = paste("Frequency of", i, sep = " "),
                      x = paste(i),
                      y = "frequency") +
                 # rescale y axis
                 scale_y_continuous(breaks = pretty_breaks(n = 15)) +
                 # rotate x axis label for 45 degrees
                 theme(axis.text.x = element_text(angle = 45,
                                                  hjust = 1))
  plot(barcharts)
  dev.off()
}

# extract a dataframe called 'quan_df' containing only 
# quantitative variables
quan_df <- Filter(is.numeric, roster_salary_stats[3:38]) 

# extract the column names of quantitative variables
quan_colnames <- names(quan_df)

# loop over each quantitative variable to create multiple boxplots
# and save them as separate pdf files
for (i in quan_colnames) {
  # produce multiple pdf files in specific file names
  pdf(paste("../../images/", i, "_boxplot.pdf", sep = ""))
  # plot boxplots with x axis as names of teams and y ais as
  # names of quantitative variables
  boxplots <- ggplot(roster_salary_stats,
                     aes_string(x = roster_salary_stats$Team,
                                y = i)) +
                     geom_boxplot() +
                     # add titles and change axis labels
                     labs(title = paste("Box Plot of", i,
                                  "(by Team)", sep = " "),
                                  x = "Team") +
                     # rescale y axis
                     scale_y_continuous(breaks = 
                                          pretty_breaks(n = 15)) +
                     # rotate x axis labels for 30 degrees
                     theme(axis.text.x = element_text(angle = 30,
                                         hjust = 1))
  plot(boxplots)
  dev.off()
}

# loop over each quantitative variable to create multiple histograms
# and save them as separate pdf files
for (i in quan_colnames) {
  # produce multiple pdf files in specific file names
  pdf(paste("../../images/", i, "_histogram.pdf", sep = ""))
  # plot histograms with x axis as names of quantitative 
  # variables
  histograms <- ggplot(roster_salary_stats,
                       aes_string(x = i)) +
                # produce histograms with binwidth = 30
                geom_histogram(bins = 30) +
                # add titles and change axis labels
                labs(title = paste("Histogram of", i, sep = " "),
                     x = paste(i)) +
                # rescale x axis
                scale_x_continuous(breaks = 
                                     pretty_breaks(n = 10)) +
                # rescale y axis
                scale_y_continuous(breaks = 
                                     pretty_breaks(n = 10))
  plot(histograms)
  dev.off()
}

# plot histogram for column 'Birth.Date', since it is in date
# format
pdf(paste("../../images/", "Birth.date_histogram.pdf", sep = ""))
# plot histograms with x axis as names of quantitative 
# variables
plot(ggplot(roster_salary_stats,
                     aes(x = roster_salary_stats$Birth.Date)) +
  # produce histograms with binwidth = 30
  geom_histogram(bins = 30) +
  # add titles and change axis labels
  labs(title = "Histogram of Birth.date (by year)",
       x = "Birth.Date") +
  # scale x axis by year
  scale_x_date(labels = date_format("%Y")) +
  # rescale y axis
  scale_y_continuous(breaks = 
                       pretty_breaks(n = 10)))
dev.off()

# =========================================================================
# Produce scatterplots to examine the correlations between variables
# =========================================================================

# scatterplot of years of experience and salary
# produce a scatterplot in pdf format
pdf(paste("../../images/", "Years.Experience_Salary.pdf", sep = ""))
plot(roster_salary_stats$Years.Experience, 
     roster_salary_stats$Salary...,
     # add titles and axis labels
     main = "Relationship between Years of Experience and Salary",
     xlab = "Years of Experience",
     ylab = "Salary($)",
     pch = 19,
     # add regression line with color red
     abline(lm(roster_salary_stats$Salary... ~
               roster_salary_stats$Years.Experience),
               col = 'red'))
dev.off()

# a linear regression model
regression_yrs_salary <- lm(roster_salary_stats$Salary... ~
                            roster_salary_stats$Years.Experience)

# calculate the correlation coefficient between two variables
r_value_yrs_salary <- cor(roster_salary_stats$Salary..., 
                          roster_salary_stats$Years.Experience)
r_value_yrs_salary

# view the descriptive statistics of this regression model
# eg. r squared value
summary(regression_yrs_salary)

# scatterplot of points gained and salary
pdf(paste("../../images/", "Points_Salary.pdf", sep = ""))
plot(roster_salary_stats$Points, 
     roster_salary_stats$Salary...,
     # add titles and axis labels
     main = "Relationship between Points and Salary",
     xlab = "Points",
     ylab = "Salary($)",
     pch = 19,
     # add regression line with color red
     abline(lm(roster_salary_stats$Salary... ~
                 roster_salary_stats$Points),
            col = 'red'))
dev.off()

# a linear regression model
regression_pts_salary <- lm(roster_salary_stats$Salary... ~
                            roster_salary_stats$Points)

# calculate the correlation coefficient between two variables
r_value_pts_salary <- cor(roster_salary_stats$Salary..., 
                          roster_salary_stats$Points)
r_value_pts_salary

# view the descriptive statistics of this regression model
# eg. r squared value
summary(regression_pts_salary)

# scatterplot of blocks and salary
pdf(paste("../../images/", "Blocks_Salary.pdf", sep = ""))
plot(roster_salary_stats$Points, 
     roster_salary_stats$Salary...,
     # add titles and axis labels
     main = "Relationship between Blocks and Salary",
     xlab = "Blocks",
     ylab = "Salary($)",
     pch = 19,
     # add regression line with color red
     abline(lm(roster_salary_stats$Salary... ~
                 roster_salary_stats$Points),
            col = 'red'))
dev.off()

# a linear regression model
regression_blk_salary <- lm(roster_salary_stats$Salary... ~
                            roster_salary_stats$Blocks)

# calculate the correlation coefficient between two variables
r_value_blk_salary <- cor(roster_salary_stats$Salary..., 
                          roster_salary_stats$Blocks)
r_value_blk_salary

# view the descriptive statistics of this regression model
# eg. r squared value
summary(regression_blk_salary)
