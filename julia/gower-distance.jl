# Gower's Distance
# an extension of the Distances.jl package

using Distances

struct Gower <: PreMetric end
struct WeightedGower <: PreMetric
    weights:W
end
# Gower might also be a SemiMetric?

# Implementation
# eval_start
# eval_op
# eval_reduce
# eval_end
const gower = Gower()
