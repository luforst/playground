# Re-writing the Bioinformatics and Systems Biology exercise R solutions in Julia
##### Sheet 1
# Nr 1a
plate96 = Matrix{Int}(undef, 8, 12)

# 1b
for i in 1:8
	for j in 1:12
		if i<3 && j>4
			plate96[i,j] = 4
		elseif i>=3 && j <=4
			plate96[i,j] = 2
		else
			plate96[i,j] = 1
		end
	end
end

# Nr 2a
using StatsBase
function discretize(x::Vector{Float64})
	y = Int[]
	q = nquantile(x, n=4)
	for i in 1:length(x)
		if x[i] <= q[2]
			y[i] = 1
		elseif q[2] < x[i] && x[i] < q[4]
			y[i] = 2
		elseif x[i] >= q[4]
			y[i] = 3
		end
	end
end
