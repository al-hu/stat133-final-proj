

# function that merges three dataframes together, based on column "Player"
# input 1 - dataframe that contains the rosters of all teams
# input 2 - dataframe that contains the salaries of each player
# input 3 - dataframe that contains the stats of each player
# output - dataframe that has the salary and stats of each player in the NBA

merge_data <- function(df1, df2, df3) {
    mydata1 <- df1[, 2:10]
    mydata2 <- df2[, 3:4]
    mydata3 <- df3[, 3:17]
    partialdata <- merge(mydata1, mydata2, by = "Player")
    myfulldata <- merge(partialdata, mydata3, by = "Player")
    return(myfulldata)
}


# ================================= TEST ====================================
mydata1 = read.csv('rawdata/roster-data/roster-ATL.csv', header = T)
mydata2 = read.csv('rawdata/salary-data/salaries-ATL.csv', header = T)
mydata3 = read.csv('rawdata/stat-data/stats-ATL.csv', header = T)


mydata1 <- mydata1[, 2:10]
mydata2 <- mydata2[, 3:4]
mydata3 <- mydata3[, 3:17]

myfulldata = merge(mydata1, mydata2, by="Player")
myfulldata = merge(myfulldata, mydata3, by = "Player")

View(mydata1)
View(mydata2)
View(mydata3)
View(myfulldata)

myfulldata

