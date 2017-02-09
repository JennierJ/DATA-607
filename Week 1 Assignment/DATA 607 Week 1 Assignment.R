
install.packages("RCurl", repos = "http://cran.us.r-project.org")
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/mushroom/agaricus-lepiota.data"

require("RCurl")
l_data <- getURL(url)
# getwd()
x <- read.csv(text=l_data,header=F,sep=",")
head(x)
str(x)
# View(x)

# class, odor, habitat
Y <- subset(x,select = c(V1,V6,V22,V23))
class(Y)
head(Y)

colnames(Y) <- c("V1"="Class", "V6"="Odor", "V22"="Population","V23"="Habitat")
head(Y)

# reference url: http://rstudio-pubs-static.s3.amazonaws.com/92398_6df0ed45b14b4b599d7fa48fa6039b6b.html

levels(Y$'Class') <- c(levels(Y$'Class'), "edible", "poison")
Y$'Class'[Y$'Class' == "e"] <- "edible"
Y$'Class'[Y$'Class' == "p"] <- "poison"

levels(Y$'Odor') <- c(levels(Y$'Odor'), "almond", "anise", "creosote", "fishy", "foul", "musty", "none", "pungent", "spicy")
Y$'Odor'[Y$'Odor' == "a"] <- "almond"
Y$'Odor'[Y$'Odor' == "l"] <- "anise"
Y$'Odor'[Y$'Odor' == "c"] <- "creosote"
Y$'Odor'[Y$'Odor' == "y"] <- "fishy"
Y$'Odor'[Y$'Odor' == "f"] <- "foul"
Y$'Odor'[Y$'Odor' == "m"] <- "musty"
Y$'Odor'[Y$'Odor' == "n"] <- "none"
Y$'Odor'[Y$'Odor' == "p"] <- "pungent"
Y$'Odor'[Y$'Odor' == "s"] <- "spicy"


levels(Y$'Population') <- c(levels(Y$'Population'), "abundant", "clustered", "numerous", "scattered", "several", "solitary")
Y$'Population'[Y$'Population' == "a"] <- "abundant"
Y$'Population'[Y$'Populationr' == "c"] <- "clustered"
Y$'Population'[Y$'Population' == "n"] <- "numerous"
Y$'Population'[Y$'Population' == "s"] <- "scattered"
Y$'Population'[Y$'Population' == "v"] <- "several"
Y$'Population'[Y$'Population' == "y"] <- "solitary"

levels(Y$'Habitat') <- c(levels(Y$'Habitat'), "grasses", "leaves", "meadows", "paths", "urban", "waste", "woods")
Y$'Habitat'[Y$'Habitat' == "g"] <- "grasses"
Y$'Habitat'[Y$'Habitat' == "l"] <- "leaves"
Y$'Habitat'[Y$'Habitat' == "m"] <- "meadows"
Y$'Habitat'[Y$'Habitat' == "p"] <- "paths"
Y$'Habitat'[Y$'Habitat' == "u"] <- "urban"
Y$'Habitat'[Y$'Habitat' == "w"] <- "waste"
Y$'Habitat'[Y$'Habitat' == "d"] <- "woods"

head(Y)

