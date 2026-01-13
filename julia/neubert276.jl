# Neubert 2021, exercise 2.7.6
# Cantorsche Paarungsfunktion

A = fill(0, (6, 6))
cantorpi(x, y) = 1/2 * (x+y) * (x+y+1) + y

for i = 1:6
	for j = 1:6
		A[i, j] = cantorpi(i-1, j-1)
	end
end

A