
# The goal of this assignment is to give you practice in preparing different datasets for downstream analysis work. 

# Your task is to: (1) Choose any three of the "wide" datasets identified in the Week 6 Discussion items.  (You may use your own dataset; please don't use my Sample Post dataset, since that was used in your Week 6 assignment!)  
# For each of the three chosen datasets: ???
# Create a .CSV file (or optionally, a MySQL database!) that includes all of the information included in the dataset.  You're encouraged to use a "wide" structure similar to how the information appears in the discussion item, 
# so that you can practice tidying and transformations as described below. ???
# Read the information from your .CSV file into R, and use tidyr and dplyr as needed to tidy and transform your data.  [Most of your grade will be based on this step!] ???
# Perform the analysis requested in the discussion item. ??? Your code should be in an R Markdown file, posted to rpubs.com, and should include narrative descriptions of your data cleanup work, analysis, and conclusions. 

# Please include in your homework submission, for each of the three chosen datasets: ??? 
# The URL to the .Rmd file in your GitHub repository, and  ???
# The URL for your rpubs.com web page. 

# Setting up environment
install.packages("tidyr",repos = "http://cran.us.r-project.org")
install.packages("tidyr")
library(tidyr)
library(dplyr)
library(ggplot2)
install.packages("urltools", repos = "http://cran.us.r-project.org")
install.packages("urltools")

# Dataset 1:Energy Efficiency Projects
data1 <- read.csv("https://raw.githubusercontent.com/Jennier2015/DATA-607/master/Project%202/Energy_Efficiency_Projects.csv")
head(data2)

# The City's Long-Term Sustainability Plan, PlaNYC, calls for City government to reduce greenhouse gas emissions produced by municipal operations 
# 30% by 2017. A large part of this effort is retrofitting municipal buildings to become more energy efficient. This dataset lists energy 
# efficiency projects at City buildings that are complete or in progress. Projects are listed by address, building name, and agency, 
# and the dataset includes the estimated reduction in tons of GHG emissions associated with the project. In summary, this dataset has 584 rows and 9 columns.
# It was provided by NYC OpenData (Thanks to Duubar Vallalobos Jimenez from Disscussion Forum)

# Data transformation
# Tidying the Data
new_data1 <- data1 %>% separate(StartDateActual, c("year", "month", "day"), sep = "-")
head(new_data2)
new_data1 <-  data1 %>% select(PrimaryProjectType:ProjectStatus)
head(new_data1)

# Analysis
table1 <- table(new_data1$PrimaryProjectType)
View(table1)
barplot(table(new_data1$PrimaryProjectType),
        main = "Energy Efficiency Projects",
        xlab = c("Comprehensive", "Audit", "HVAC", "Lighting", "Other"),
        ylab = "Frequency")

table2 <- table(new_data1$ProjectStatus)
View(table2)
sum(table2)

# Conclusion: In NYC, there are more lighting upgrade projects than the other kinds of energy efficiency projects. And other than regular and common types of projects, there are still a good amount of other projects
# for energy efficiency. And regarding the project status, out of 584 projects, there are 260 completed projects, which is a good rate of projects accomplished.

# Dataset 2: 
data2 <- read.csv("https://raw.githubusercontent.com/Jennier2015/DATA-607/master/Project%202/Energy_Usage_From_DOE_Buildings.csv")
head(data2)
View(data2)

# The dataset is from Energy data from a select portfolio of City-owned buildings (DOE) provided by NYC OpenData.

# Data transformation
# Tidying the Data
# Because the 2008 and 2012 data is not for the whole year, I would like to exclude the data from 2008 and 2012.
data_whole <- data2[ -c(3:10, 47:52)]
View(data_whole)


# I want to select the 2009 dataset for total usage and do some analysis.
data_2009 <- filter(data_whole, data_whole$Measurement == "Total Usage (mmBTUs)")
View(data_2009)
data_2009_totalusage <- select(data_2009, Jan.09 :Dec.09)

View(data_2009_totalusage) 

# Change fiscal month to regular name Jul.09 
colnames(data_2009_totalusage)[7] <- "Jul.09"
View(data_2009_totalusage)



# Dataset 3: Wastewater Treatment Plants
# The dataset is provided by Department of Environmental Protection (DEP).
data3 <- read.csv("https://raw.githubusercontent.com/Jennier2015/DATA-607/master/Project%202/Wastewater_Treatment_Plants.csv")
head(data3)

# Tidying the Data
data3_analysis <- select(data3, Location, Population.Served)
View(data3_analysis)
arrange(data3_analysis, Location)
data3_analysis %>% 
  summarise(mean = mean(data3_analysis$Population.Served), sum = sum(data3_analysis$Population.Served), n = n())
# The mean population servied for each is 553821.8, and total popluation is 7753505.

# Analysis Question: How are the wastewater treatment plants spreaded out based on location?
plot(data3_analysis$Population.Served ~ data3_analysis$Location)
# Conclusion: 1. The average population servied for each plant is 553821.8. 2. The average population servied at north are higher than East and South.
