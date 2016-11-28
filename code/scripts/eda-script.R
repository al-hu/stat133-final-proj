setwd("/Users/Nicole/Desktop/stat133-final-proj/data/cleandata")
library(ggplot2)
library(scales)

roster_salary_stats <- read.csv("roster-salary-stats.csv")

# convert column 'Number' to factor
factorized <- as.factor(roster_salary_stats$Number)
roster_salary_stats$Number <- factorized

# compute summary statistics to each variable 
# excluding the first column
lapply(roster_salary_stats[2:38], summary)

# redirect output to the current working directory
sink(file = 'eda-output.txt', append = TRUE)

# extract a dataframe containing only qualitative variables
qual_df <- Filter(is.factor, roster_salary_stats[3:38]) 

# extract the column names of qualitative variables
qual_colnames <- names(qual_df)

# loop over each qualitative variable to create multiple barcharts
barcharts_list <- list()
for(i in qual_colnames) {
  barcharts <- ggplot(roster_salary_stats,
                      aes_string(x = i)) +
    geom_bar() +
    labs(title = paste("Frequency of", i, sep = " "),
      x = paste(i),
      y = "frequency") +
    scale_y_continuous(breaks = pretty_breaks(n = 15)) +
    theme(axis.text.x = element_text(angle = 45,
                                     hjust = 1))
  barcharts_list[[i]] <- barcharts
}

# Create pdf file including all boxplots 
# where each page is a separate plot
pdf("../../images/Barcharts.pdf")
for (i in qual_colnames) {
  print(barcharts_list[[i]])
}
dev.off()

# extract a dataframe containing only quantitative variables
quan_df <- Filter(is.numeric, roster_salary_stats[3:38]) 

# extract the column names of quantitative variables
quan_colnames <- names(quan_df)

# loop over each quantitative variable to create multiple boxplots
boxplots_list <- list()
for (i in quan_colnames) {
  boxplots <- ggplot(roster_salary_stats,
                     aes_string(x = roster_salary_stats$Team,
                                y = i)) +
    geom_boxplot() +
    labs(title = paste("Box Plot of", i,
                       "(by Team)", sep = " "),
         x = "Team") +
    scale_y_continuous(breaks = pretty_breaks(n = 15)) +
    theme(axis.text.x = element_text(angle = 30,
                                     hjust = 1))
  boxplots_list[[i]] <- boxplots
}

# Create pdf file including all boxplots 
# where each page is a separate plot
pdf("../../images/Boxplots.pdf")
for (i in quan_colnames) {
  print(boxplots_list[[i]])
}
dev.off()

# loop over each quantitative variable to create multiple histograms
histograms_list <- list()
for (i in quan_colnames) {
  histograms <- ggplot(roster_salary_stats,
                       aes_string(x = i)) +
                geom_histogram(bins = 30) +
                labs(title = paste("Histogram of", i, sep = " "),
                     x = paste(i)) +
                scale_x_continuous(breaks = 
                                     pretty_breaks(n = 10)) +
                scale_y_continuous(breaks = 
                                     pretty_breaks(n = 10))
  histograms_list[[i]] <- histograms
}

# Create pdf file including all histograms 
# where each page is a separate plot
pdf("../../images/Histograms.pdf")
for (i in quan_colnames) {
  print(histograms_list[[i]])
}
dev.off()
