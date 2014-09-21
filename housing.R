require(dplyr)

housing <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
housing <- tbl_df(housing)
print("Question 1")
print(housing %>% filter(VAL == 24) %>% summarize(n()))
# or: housing %>% filter(VAL == 24) %>% nrow %>% print

require(xlsx)
if (!file.exists("data")) {
    dir.create("data")
}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url, destfile = "./data/gap.xlsx", mode= "wb")
dateDownloaded <- date()

dat <- read.xlsx("./data/gap.xlsx", 1, rowIndex = 18:23, colIndex = 7:15, header = TRUE)

print("Question 3")
print(sum(dat$Zip * dat$Ext, na.rm=TRUE))

library(XML)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(url, destfile = "./data/restaurants.xml", mode= "wb")
restaurants <- xmlTreeParse("./data/restaurants.xml", useInternal = TRUE)

print("Question 4")
print(length(xpathSApply(restaurants,"//zipcode[. = '21231']", xmlValue)))
print(restaurants %>% xpathSApply("//zipcode[. = '21231']", xmlValue) %>% length)

