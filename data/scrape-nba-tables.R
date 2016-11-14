# =========================================================================
# Title: Scrape raw html tables
#
# Description:
# This script contains R code to help you scrape the tables 
# 'Roster', 'Totals', and 'Salaries', for a specific NBA team.
# Each table is read as a data.frame, which is then exported as a csv file
# to the corresponding subdirectory in the 'rawdata/' folder
# =========================================================================

# =========================================================================
# Make sure to be have the correct working directory set up or else
# you might get errors!  For me, (Albert), my working directory was 
# "/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/data"

setwd('/home/albert/Documents/Albert/Fall16/Stat133/stat133-final-proj/data')

# =========================================================================

library(XML)

# base url
basketref <- 'http://www.basketball-reference.com'

# =========================================================================
# The desired html tables are in URL's having this form:
# "http://www.basketball-reference.com/teams/CLE/2016.html"
# "http://www.basketball-reference.com/teams/TOR/2016.html"
# "http://www.basketball-reference.com/teams/MIA/2016.html"
# ...
#
# The first step is to extract the part of the url associate with each
# team, that is: /teams/CLE/2016.html, /teams/TOR/2016.html, ...
#
# To do that, we'll scrape the the page:
# "http://www.basketball-reference.com/leagues/NBA_2016.html"
# in order to extract the 'href' attributes of the anchor tags:
# /teams/CLE/2016.html
# /teams/TOR/2016.html
# /teams/MIA/2016.html
# ...
#
# These attributes are extracted as a character vector
# (these will be used to parse each team's page)
# =========================================================================

# parse 'http://www.basketball-reference.com/leagues/NBA_2016.html'
url <- paste0(basketref, '/leagues/NBA_2016.html')
doc <- htmlParse(url)

# identify nodes with anchor tags for each team and
# extract the href attribute from the anchor tags
team_rows <- getNodeSet(doc, "//th[@scope='row']/a")
team_hrefs <- xmlSApply(team_rows, xmlAttrs)

# just in case, here's the character vector with the team abbreviations
team_names <- substr(team_hrefs, 8, 10)


# =========================================================================
# Scrape the tables Roster, Totals, and Salaries.
# Now we can pass the first value in 'team_hrefs' to the base url, and form:
# http://www.basketball-reference.com/teams/CLE/2016.html
# 
# The code below scrapes the tables for the Cleveland Cavaliers (CLE)
# You will have to write a loop that iterates over each team page
# and scrapes the required tables
# =========================================================================

# Read html document (as a character vector) for a given team
# (first team is "CLE")
    
for (i in 1:length(team_hrefs)) {
    url_team <- paste0(basketref, team_hrefs[i])
    print(i)
    html_doc <- readLines(con = url_team)
    
    # initial line position of roster html table
    begin_roster <- grep('id="roster"', html_doc)
    # find the line where the html ends
    line_counter <- begin_roster
    
    while (!grepl("</table>", html_doc[line_counter])) {
        line_counter <- line_counter + 1
    }
    # read roster table as data.frame and export it as csv
    roster <- readHTMLTable(html_doc[begin_roster:line_counter])
    roster <- roster[[1]]
    roster_file_name <- paste0('rawdata/roster-data/roster-', team_names[i], '.csv')

    if (!file.exists(roster_file_name)) {
        file.create(roster_file_name)
        write.csv(roster, file = roster_file_name)
    }
    
    # initial line position of totals html table
    begin_totals <- grep('id="totals"', html_doc)
    # find the line where the html ends
    line_counter <- begin_totals
    while (!grepl("</table>", html_doc[line_counter])) {
        line_counter <- line_counter + 1
    }
    # read totals table as data.frame and export it as csv
    totals <- readHTMLTable(html_doc[begin_totals:line_counter])
    totals <- totals[[1]]
    
    totals_file_name <- paste0('rawdata/stat-data/stats-', team_names[i], '.csv')
    
    if (!file.exists(totals_file_name)) {
        file.create(totals_file_name)
        write.csv(totals, file = totals_file_name)
    }
    
    # initial line position of salaries html table
    begin_salaries <- grep('id="salaries"', html_doc)
    # find the line where the html ends
    line_counter <- begin_salaries
    while (!grepl("</table>", html_doc[line_counter])) {
        line_counter <- line_counter + 1
    }
    
    # read salaries table as data.frame and export it as csv
    salaries <- readHTMLTable(html_doc[begin_salaries:line_counter])
    salaries <- salaries[[1]]
    salaries_file_name <- paste0('rawdata/salary-data/salaries-', team_names[i], '.csv')
    if (!file.exists(salaries_file_name)) {
        file.create(salaries_file_name)
        write.csv(salaries, file = salaries_file_name)
    }
}




