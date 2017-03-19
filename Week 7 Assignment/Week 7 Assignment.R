# Week 7 Assignment

install.packages("RCurl")
install.packages("XML")

library(RCurl)
library(XML)
library(jsonlite)

# Loading HTML
html.URL <-
  getURL("https://raw.githubusercontent.com/Jennier2015/DATA-607/master/Week%207%20Assignment/books.html")
books.html <- readHTMLTable(html.URL, header = TRUE)
books.html

# Loading XML
xml.URL <-
  getURL("https://raw.githubusercontent.com/Jennier2015/DATA-607/master/Week%207%20Assignment/books.xml")
books.xml <- xmlParse(xml.URL)
books_xml <- xmlToDataFrame(books.xml)
books_xml

# Loading json
json.URL <-
  getURL("https://raw.githubusercontent.com/Jennier2015/DATA-607/master/Week%207%20Assignment/books.json")
books.json <- fromJSON(json.URL)
books.json 

# Without the additional processing, the three data frame are not identical. 