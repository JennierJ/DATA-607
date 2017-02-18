# Problem 3
# From Automated Data Collection with R; introductory example.
raw.data <-  "555-1239Moe Szyslak(636) 555-0113Burns, C. Montgomery555 -6542Rev. Timothy Lovejoy555 8904Ned Flanders636-555-3226Simpson, Homer5553642Dr. Julius Hibbert"
library(stringr)
name <- unlist(str_extract_all(raw.data, "[[:alpha:]., ]{2,}"))
name
# 3(a)
name = str_replace_all(name, pattern = "Rev. |Dr.", replacement = "")
View(name)
# From page 205 Automated Data Collection with R
last_names = str_extract_all(name, "\\W+,")
first_names = str_extract_all(name, ",\\w+")
right_order = paste(first_names, last_names)
comma_place = grep(name, ",")
name[comma_place] <- right_order[comma_place]
name = str_trim(str_replace_all(name, ",", ""))
name

# 3(b)
# From page 209, Automated Data Collection with R
raw.data <-  "555-1239Moe Szyslak(636) 555-0113Burns, C. Montgomery555 -6542Rev. Timothy Lovejoy555 8904Ned Flanders636-555-3226Simpson, Homer5553642Dr. Julius Hibbert"
name <- unlist(str_extract_all(raw.data, "[[:alpha:]., ]{2,}"))
name_titles = str_detect(name, "Rev.|Dr.")
name_titles

# 3(c)
# From page 204, Automated Data Collection with R 
name = str_replace_all(name, pattern = "Rev. |Dr.", replacement = "")
name_second <- str_detect(name, "\\.")
name_second
name[name_second == TRUE]

# Problem 4
# (a) [0-9]+\\$: To match any digit number from 0-9 in the string
test1 <- "500$"
str_extract_all(test1, "[0-9]+\\$")

# (b) \\b[a-z]{1,4}\\b: To match lowercase letters to maximum 4 characters.
test2 <- "I am going to California next week for vacation."
str_extract_all(test2, "\\b[a-z]{1,4}\\b")

# (c) .*?\\.txt$: To match the string that ending with ".txt"
test3 <- c(".txt", "tom.txt", "data607.txt", "data606.txt")
unlist(str_extract_all(test3, ".*?\\.txt$"))

# (d) \\d{2}/\\d{2}/\\d{4}: To match the expression includes two digit/two digit/four digit, such as dates in format mm/dd/yyyy.
test3 <- c("03/05/1989", "12/31/1988", "Jan 10, 1992", "12/10/1959", "May 12, 1989")
unlist(str_extract_all(test3, "\\d{2}/\\d{2}/\\d{4}"))

# (e) "<(.+?)>.+?</\\1>: To match expression start with < > and end with </ any string >.
test4 <- c("<script> R is fun </script>")
unlist(str_extract_all(test4, "<(.+?)>.+?</\\1>"))
