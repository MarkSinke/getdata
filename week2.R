setwd("y:/datascience/getdata/")

print("Question 4");
require(dplyr)

lines <- readLines("http://biostat.jhsph.edu/~jleek/contact.html")
charCounts <- lines %>% nchar
print(charCounts[10])
print(charCounts[20])
print(charCounts[30])
print(charCounts[100])
    
print("Question 5")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", 
                       "data/week2q5.for", mode="wb")
data <- read.fwf("data/week2q5.for", widths = c(15, 4, 9, 4, 9, 4, 9, 4, 9), skip = 4)
print(data %>% select(V4) %>% sum)