library(bitops)
library(RCurl)
library(jsonlite)
library(stringr)

urlfn <- function(i) {
  url <- paste("http://service.dice.com/api/rest/jobsearch/v1/simple.json?text=data+science&page=", i, sep="")
  return(url)
}
mainURL <- sapply(1:778, urlfn)
mainURL


# Main Table

jobcontent <- getURL(mainURL)
jobs <- fromJSON(jobcontent)
class(jobs)
names(jobs)
names(jobs$resultItemList)

mainDF <- jobs$resultItemList
Suburls <- mainDF$detailUrl 
Suburls

# Sub Table

Suburls[5]
text <- readLines(Suburls[5])
text <- str_c(text, collapse = "")

# jobskills <- c("Python","R","analytics","machine learning","programming","team","statistics","SQL","sql","communication","big data","design","Hadoop","Java","research","creative","math","mathematic","MATLAB","predictive analytics","SAS","Modelling","C++","builders at heart","experienced","outgoing","self-motivated professional","creating analytics programs","thought leadership" )

jobskills <- c("Python"," R ","analytics","leadership","programming")

for (skill in jobskills) {
  print(skill)
  print(lapply(skill, str_count, string=text))
}
print(text)


counter <- 1

sub_df <- data.frame(counter, "xyz", "abd", 1)
names(sub_df) <- c("1", "2", "3", "4")

df_list <- sapply(Suburls, function(suburl){
  text <- readLines(suburl)
  text <- str_c(text, collapse = "")
  # row <- c(counter, suburl, "abd", 1)
  sub_df2 <- data.frame(counter, suburl, "abd", 1)
  names(sub_df2) <- c("1", "2", "3", "4")
  # print(sub_df)
  for (skill in jobskills) {
  # print(skill)
  # print(lapply(skill, str_count, string=text))
    counter <-  counter + 1
    count <- lapply(skill, str_count, string=text)
    # row <- c(counter, suburl, skill, count)
    sub_df1 <- data.frame(counter, suburl, skill, count)
    names(sub_df1) <- c("1", "2", "3", "4")
    sub_df2<- rbind(sub_df2, sub_df1)
   #  list(sub_df = sub_df)
    # print(sub_df)
  }
  return(sub_df2)
})
#print(sub_df)
#dim(sub_df)
length(df_list)
suf_list <- rbind(df_list)
print(suf_list)
