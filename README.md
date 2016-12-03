# Determinants of NBA Players' Salary

### UC Berkeley Stat133 Final Project

**Authors:** Albert Hu, Zihan Chen, Ming Ho Cheung, Xinruo Hu

**Description of project:** We investigated the relationship between an NBA player's skills/stats and his salary in the 2015-2016 NBA season.  In doing so, we pulled data on all of the 471 athletes who played in the 2015-2016 season off of the [Basketball Reference website](http://www.basketball-reference.com/).  We focused in particular on analyzing game statistics of each player, using principal component analysis(PCA) to calculate a weighted efficiency index for each player based on their in-game performance, as well as taking into consideration the position that they play (center, power forward, small forward, point guard, and shooting guard).

**Organization of directories and files:** All of the code and data used within this project is in this repository.  The scripts used to scrape data off the internet, clean the data, and create various CSVs are found within the code/scripts folder.  They may have used some functions whcih were defined in the code/functions folder.  The raw data that was directly scraped from the internet is located within the data/rawdata folder, and cleaned data (including the results of some exploratory analysis of our data) is located in data/cleandata.  All images that we used (as well as many others) are located within the images folder.  Our full report, available in RMarkdown, PDF, and HTML format, are located in the report folder, and our slides detailing our findings are located within the slides folder.  Finally, we also created two shiny apps that are hosted online.  The first visualizes the salary statistics per team, and can be viewed [here](https://al-hu.shinyapps.io/team-salaries/).  The source code is located in apps/team-salaries.  The second shiny app explores the relationship between various in-game statistics and salaries, and can be viewed [here](https://al-hu.shinyapps.io/stat-salaries/).

**Additional instructions:**
Install the packages "dplyr", "shiny", "FactoMineR", and "ggplot2" with the commands:

install.packages("dplyr")  
install.packages("shiny")  
install.packages("ggplot2")  
install.packages("FactoMineR")

The Rmd file for our final can be knitted in RStudio into an html, pdf, or Word document.

Github link: https://github.com/al-hu/stat133-final-proj
