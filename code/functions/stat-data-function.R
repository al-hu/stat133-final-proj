# test if rbind() works in the situation of only merging first two dataframes
setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/data/rawdata")

mydata1 = read.csv("stat-data/stats-ATL.csv", header = T)
mydata2 = read.csv("stat-data/stats-BOS.csv", header = T)
myfulldata = rbind(mydata1, mydata2)
myfulldata
# the function to read.csv all files and then combine them together as a big dataframe
# setwd("~/Desktop/stat133-final-proj/data/rawdata/stat-data")
files <- list.files(pattern = "../../data/rawdata/stat-data/*.csv")
files
myfiles = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))
myfiles
View(myfiles)
