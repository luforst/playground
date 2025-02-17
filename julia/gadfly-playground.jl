using CSV
using DataFrames
using Gadfly
using RDatasets

iris = dataset("datasets", "iris")
p = plot(iris, x=:SepalLength, y=:SepalWidth, Geom.point);
img = SVG("iris_plot.svg", 14cm, 8cm)
draw(img, p)

plot(iris, x=:SepalLength, y=:SepalWidth)

function generate_some_plots(d)
    ppoint = plot(d, x=:SepalLength, y=:SepalWidth, Geom.point)
    pline = plot(d, x=:SepalLength, y=:SepalWidth, Geom.line)
    ppoint, pline
end
ps = generate_some_plots(iris)
map(display, ps)

plot(iris, x=:SepalLength, y=:SepalWidth, Geom.point, Geom.line) # doesn't make sense, but is possible
plot(iris, x=:SepalLength, y=:SepalWidth, color=:Species, shape=:Species, Geom.point)
plot(iris, x=:SepalLength, y=:SepalWidth, color=:Species, Geom.line)

plot(iris, x=:Species, y=:SepalWidth, colour=:Species, Geom.boxplot)
plot(iris, x=:Species, y=:SepalLength, colour=:Species, Geom.boxplot)

plot(iris, x=:SepalLength, y=:PetalLength, colour=:Species, Geom.point)
