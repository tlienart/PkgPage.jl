module PackagePage

import Franklin

export serve

export lx_lead
export lx_begin, lx_end

export hfun_col

const F = Franklin

serve() = F.serve(clear=true)

include("utils.jl")

include("formatting.jl")
include("envs/begin-end.jl")
include("envs/section.jl")

end # module
