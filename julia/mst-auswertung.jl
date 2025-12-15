using CSV
using DataFrames
using Gadfly

# data set MST.csv is not in the repository due to being unpublished research data
MST = CSV.read("MST.csv", DataFrame)
names(MST)

plot(MST, x=:MSTright, y=:MSTleft, Geom.point)
plot(MST, x=:SQRright, y=:SQRleft, Geom.point)
plot(MST, x=:MSTright, y=:SQRright, Geom.point)
plot(MST, x=:MSTright, y=:SQRright, Geom.smooth)

p = plot(MST, x=:MSTright, y=:MSTleft, Geom.point)
img = SVG("MST_left-right-corr.svg", 12cm, 12cm)
draw(img, p)
