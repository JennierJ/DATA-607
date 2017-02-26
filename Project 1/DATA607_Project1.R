# DATA 607 - Project 1 Chess Tournament Results
# Introduction
# In this project, you're given a text file with chess tournament results where the information has some structure. Your
# job is to create an R Markdown file that generates a .CSV file (that could for example be imported into a SQL database)
# with the following information for all of the players:
# Player's Name, Player's State, Total Number of Points, Player's Pre-Rating, and Average Pre Chess Rating of Opponents
# For the first player, the information would be:
# Gary Hua, ON, 6.0, 1794, 1605

library(stringr)

# Read Data
# 
tournament <- read.csv('https://raw.githubusercontent.com/Jennier2015/DATA-607/master/Project%201/tournamentinfo.txt', skip = 3)
head(tournament)

# Clean Data using Regular Expressions

# Extract Player's Name
Player_Name <- str_trim(unlist(str_extract_all(unlist(tournament), "[[:upper:]_]+(\\ [[:upper:]_]+ ([[:upper:]_]|-)* [[:upper:]_]*)")))
Player_Name

# Extract Player's State
Player_State <- str_trim(unlist(str_extract_all(unlist(tournament), " {3}[[:upper:]]{2} ")))
Player_State

# Extract Total Number of Point
Total_Number_Points <- str_trim(unlist(str_extract_all(unlist(tournament), "([[:digit:]]\\.[[:digit:]])")))
Total_Number_Points

# Extract Player's Pre-Rating
pre_rating1 <- str_trim(unlist(str_extract_all(unlist(tournament), "R: [[:digit:] ]*")))
pre_rating <- str_replace_all(pre_rating1, "R: ", "")
pre_rating

data <- data.frame(Player_Name, Player_State, Total_Number_Points, pre_rating)
data

# export
write.csv(data, "data.cvs", row.names = FALSE)
