# week 3 R script
library(dplyr)

downloadIfRequired <- function(url, destfile) {
    if (!file.exists(sprintf("data/%s", destfile))) {
        if (!file.exists("data")) {
            dir.create("data")
        }
        download.file(url = url, destfile = sprintf("data/%s", destfile), mode = "wb")
    }
}

#===================
print("Question #1")
downloadIfRequired("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "housing.csv")
housing <- read.csv("data/housing.csv")

names_split <- strsplit(names(housing), "wgtp")
print(names_split[123])

#===================
print("Question #2")

downloadIfRequired("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "gdp.csv")

gdp <- tbl_df(read.csv("data/gdp.csv", skip = 5, header = FALSE, stringsAsFactors = FALSE)) %>% 
    select(country_code = V1, rank = V2, country = V4, gdp = V5) %>%
    head(190) %>%
    mutate(rank = as.integer(rank), gdp = as.numeric(gsub(",", "", gdp)))

print(mean(gdp$gdp))

#===================
print("Question #3")

countryNames <- gdp$country

print(length(grep("^United", countryNames)))

#===================
print("Question #4")

downloadIfRequired("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "education.csv")

education <- tbl_df(read.csv("data/education.csv", stringsAsFactors = FALSE))

merged <- tbl_df(merge(gdp, education, by.x = "country_code", by.y = "CountryCode"))

notes <- merged$Special.Notes

withEnd <- grep("Fiscal Year End: June", notes, ignore.case = TRUE)

print(length(withEnd))

#===================
print("Question #5")

library(quantmod)
amzn <- getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn) 

library(lubridate)

in2012 <- grep("^2012-", sampleTimes, value = TRUE)
mondays <-grep("Monday", weekdays(ymd(in2012)), value = TRUE)

print(length(in2012))
print(length(mondays))