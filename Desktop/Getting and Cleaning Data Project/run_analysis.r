#Week 4 Quiz 4

#Question 1

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
f <- file.path(getwd(), "housing.csv")
download.file(url, f)
data <- read.csv("housing.csv")

varsplit <- strsplit(names(data),"wgtp")
varsplit[[123]]

#Question 2

library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(),"GDP.csv")
download.file(url,f)
dtGDP <- data.table(read.csv(f, skip = 4, nrows = 215, stringsAsFactors = FALSE))
dtGDP <- dtGDP[X != ""]  #remove those empty rows with no mention of country
dtGDP <- dtGDP[, list(X,X.1, X.3, X.4)]  #create a new list and datasets
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
gdp <- as.numeric(gsub(",","", dtGDP$gdp))
mean(gdp, na.rm = TRUE)

# Question 3

grep("^United",dtGDP$Long.Name)

# Question 4

library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(),"GDP.csv")
download.file(url,f)
dtGDP <- data.table(read.csv(f, skip = 4, nrows = 215, stringsAsFactors = FALSE))
dtGDP <- dtGDP[X != ""]  #remove those empty rows with no mention of country
dtGDP <- dtGDP[, list(X,X.1, X.3, X.4)]  #create a new list and datasets
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "EDSTATS_Country.csv")
download.file(url, f)
dtEd <- data.table(read.csv(f))
dt <- merge(dtGDP, dtEd, all=TRUE, by=c("CountryCode"))
isFiscalYearEnd <- grep1("fiscal year end", tolower(dt$Special.Notes))
isJune <- grep1("june, tolower"(dt$Special.Notes))
table(isFiscalYearEnd, isJune)

# Question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))  #create a multidimensional table including year, and no. of days



