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
# Extract Average Pre Chess Rating of Opponents
# Reference: https://rstudio-pubs-static.s3.amazonaws.com/212587_0c7bf965b27747da8c66803b15fe4534.html
# Step 1: Extract player's opponents
opp_number <- unlist(str_extract_all(unlist(tournament),"[WDL]...\\d{1,2}"))
opp_number <- unlist(str_extract_all(unlist(opp_number),"\\.?\\d{1,2}"))
opp_number <- str_replace_all(opp_number,"\\b[0]\\b",".")
opp_number <- as.numeric(opp_number)
head(opp_number)

opp_number <- str_extract_all(unlist(tournament),"[WDL]...\\d{1,2}")
opp_number <- str_extract_all(unlist(opp_number),"\\.?\\d{1,2}")
opp_number <- str_replace_all(opp_number,"\\b[0]\\b",".")
opp_number <- as.numeric(opp_number)
head(opp_number)

# Step 2: Convert to numeric data
data$Total_Number_Points <- as.numeric(as.character(data$Total_Number_Points))
data$pre_rating <- as.numeric(as.character(data$pre_rating))

# Step 3: Calculate Mean
ave <- array(0, dim = nrow(data))
for (i in 1:nrow(data)){
  match_opp <- as.numeric(unlist(str_extract_all(opp_number[i])))
  ave[i] <- mean(data(match_opp, colnames(data) == "Pre_rating_opponents", na.rm = T))
};

data$Pre_rating_opp <- ave
head(data)

# export
write.csv(data, "data.cvs", row.names = FALSE)
