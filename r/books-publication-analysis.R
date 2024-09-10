booksdata <- read.csv("bookyears.csv", stringsAsFactors = F)
numdata <- data.frame(data.matrix(x))
hist(numdata$year, breaks=c(1800,1820,1840,1860,1880,1900,1910,1920,1930,1940,1950,1960,1970,1980,1990,2000,2010,2020,2025),)
