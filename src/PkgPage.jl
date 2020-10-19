module PkgPage

import Franklin
import CommonMark
import NodeJS
using Pkg: TOML
using FranklinUtils

export newpage
export serve

export lx_lead, lx_figure, lx_alert
export env_column, env_table, env_section
# export lx_begin, lx_end, lx_column

export hfun_col

const F = Franklin

include("instantiate.jl")

include("latex/basic.jl")
# include("coms/begin-end.jl")
include("latex/environments.jl")

end # module
