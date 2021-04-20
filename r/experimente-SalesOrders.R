# Teil 1: im live-Interpreter anzeigen lassen
SalesOrders <- read.csv("SalesOrders.csv", sep=";")
View(SalesOrders)
str(SalesOrders)
SalesOrders$BuyerRef[1:5]
str(SalesOrders$DeliveryDate)
today <- "2021-04-18"
str(today)
d1 <- asDate(today, format="%Y-%m-%d")
d1 <- as.Date(today, format="%Y-%m-%d")
str(d1)
S0 <- SalesOrders[1:10, ]
SalesOrders$DeliveryDate <- as.Date(SalesOrders$DeliveryDate, format="%Y-%m-%d")
str(SalesOrders$DeliveryDate)
# Teil 2
attach(SalesOrders) # nie in Skripten verwenden!
names(SalesOrders)
#Eindimensionale Plots
hist(BuyerRef) #Histogramm für erste Spalte
hist(DeliveryDate, "weeks") #spezielle hist() Fkt für Date Klasse
hist(TotalPrice)
hist(PaymentDuration)
# 2-dimensionale Korrelationsplots
plot(BuyerRef, PaymentDuration)
smoothScatter(BuyerRef, PaymentDuration)
smoothScatter(TotalPrice, PaymentDuration)
plot(TotalPrice, PaymentDuration, cex=0.3)
scatterplotMatrix(SalesOrders, diagonal="histogram", cex=0.5, smooth=FALSE, reg.line=FALSE)
q()
