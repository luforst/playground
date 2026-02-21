# library(readODS)
# remotes::install_github("mattkerlogue/tidyods")
library(tidyods) # for importing ODS files, available only on GitHub and not in CRAN

currentyear <- as.numeric(format(Sys.Date(), "%Y"))

#Lesedaten <- read_ods("Belletristik-Leseliste.ods")
#ods_file <- system.file("extdata", "Belletristik-Leseliste.ods", package = "tidyods")
#ods_sheets(ods_file)

Lesedaten <- read_ods_sheet("Belletristik-Leseliste.ods")[-1, ]
Lesedaten$x9 <- as.numeric(Lesedaten$x9)
hist(Lesedaten$x9, breaks = c(-500, 0, 1000, 1200, 1400, 1600, 1800, 1820, 1840, 1860, 1880, 1900, 1920, 1940, 1960, 1980, 2000, 2020, currentyear))
