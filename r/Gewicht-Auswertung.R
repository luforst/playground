daten <- read.csv("Gewichtswerte.csv")
pdf(file="Gewicht-Histogramm.pdf")
hist(daten$Gewicht, xlab="Gewicht in kg")
dev.off()
