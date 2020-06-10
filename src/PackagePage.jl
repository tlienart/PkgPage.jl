module PackagePage

import Franklin
import CommonMark

export serve

export lx_lead, lx_figure, lx_table
export lx_begin, lx_end, lx_column

export hfun_col

const F = Franklin

serve() = F.serve(clear=true)

include("utils.jl")

include("coms/basic.jl")
include("coms/begin-end.jl")

end # module
