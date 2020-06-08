module PackagePage

import Franklin

export serve

export lx_lead, lx_figure
export lx_begin, lx_end, lx_column

export hfun_col

const F = Franklin

serve() = F.serve(clear=true)

include("utils.jl")

include("coms/basic.jl")
include("coms/begin-end.jl")

end # module
