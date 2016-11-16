setwd("/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/code/functions")





file_path <- "../../data/rawdata/salary-data/"
files <- list.files(path = file_path, pattern = "*.csv")
files
myfiles = do.call(rbind, lapply(files, function(x) {
    read.csv(paste0(file_path, x), stringsAsFactors = FALSE)
}))

View(myfiles)
