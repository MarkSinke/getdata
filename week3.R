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

print("Question #1")
downloadIfRequired("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "housing.csv")
housing <- read.csv("data/housing.csv")

agricultureLogical = housing[housing$ACR == 3 && housing$AGS == 6]

indices <- 1:nrow(housing)

housing <- cbind(indices, housing)

print(housing %>% filter(ACR == 3 & AGS == 6) %>% select(indices) %>% head(3))

# =======================

print("Question #2")

library(jpeg)

downloadIfRequired("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "jeff.jpg")

jpeg <- readJPEG(source = "data/jeff.jpg", native = TRUE)

quantiles <- quantile(jpeg, c(0.3, 0.8))
print(quantiles)

# =======================

print("Question #3")

downloadIfRequired("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "gdp.csv")

gdp <- tbl_df(read.csv("data/gdp.csv", skip = 5, header = FALSE, stringsAsFactors = FALSE)) %>% 
    select(country_code = V1, rank = V2, country = V4, gdp = V5) %>%
    head(190) %>%
    mutate(rank = as.integer(rank), gdp = as.numeric(gsub(",", "", gdp)))

downloadIfRequired("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "education.csv")

education <- tbl_df(read.csv("data/education.csv"))

merged <- merge(gdp, education, by.x = "country_code", by.y = "CountryCode")

print(nrow(merged))

print(merged %>% arrange(desc(rank)) %>% head(13) %>% tail(1) %>% select(country))

# =======================

print("Question #4")

meanGdp <- merged %>% 
    group_by(Income.Group) %>%
    summarize(mean(rank))

print(meanGdp)

print("Question #5")

lmiInTop38 <- merged %>% 
    arrange(rank) %>% 
    head(38) %>% 
    filter(Income.Group == "Lower middle income")

print(nrow(lmiInTop38))
