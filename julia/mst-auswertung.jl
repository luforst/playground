using CSV
using DataFrames
using Gadfly

# data set MST.csv is not in the repository due to being unpublished research data
MST = CSV.read("MST.csv", DataFrame)
names(MST)

plot(MST, x=:MSTright, y=:MSTleft, Geom.point)
plot(MST, x=:SQRright, y=:SQRleft, Geom.point)
