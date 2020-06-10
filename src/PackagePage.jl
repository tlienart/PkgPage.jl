module PackagePage

import Franklin
import CommonMark
import NodeJS

export newpage
export serve

export lx_lead, lx_figure, lx_table, lx_alert
export lx_begin, lx_end, lx_column

export hfun_col

const F = Franklin

include("instantiate.jl")

include("utils.jl")
include("coms/basic.jl")
include("coms/begin-end.jl")

end # module
