install.packages("rmarkdown")
install.packages("knirt")


# Read Data
data = read.csv("https://raw.githubusercontent.com/Jennier2015/DATA-607/master/Week%205%20Assignment/arrival_delays.csv")
View(data)

# Set Up Environment

library(tidyr)
library(dplyr)
library(ggplot2)


# Tidy data
tidy_data1 <- gather(data, "Designation", "Count", 3:7)
tidy_data1

tidy_data2 <- spread(tidy_data1, "Arrival", "Count")
tidy_data2


# Transform
transform_data1 <- select(data, Airline, Arrival, Los.Angeles)
transform_data1

transform_data2 <- arrange(tidy_data1, Designation)
transform_data2

transform_data3 <- mutate(tidy_data2,
                          total_flights = tidy_data2$delayed + tidy_data2$`on time`,
                          delayed_percent = (delayed / total_flights * 100))
transform_data3
                    

# Analysis
Analysis1 <- filter(transform_data3, Airline == "ALASKA")
Analysis1

barplot(Analysis1$delayed_percent,
        main = "Delayed Percent of ALASKA",
        names.arg = c("Los.Angeles","Phoenix","San.Diego","San.Francisco","Seattle"),
        ylab = "Delayed Percent")

Analysis2 <- filter(transform_data3, Airline == "AM WEST")
Analysis2

barplot(Analysis2$delayed_percent,
        main = "Delayed Percent of AM WEST",
        names.arg = c("Los.Angeles","Phoenix","San.Diego","San.Francisco","Seattle"),
        ylab = "Delayed Percent")
