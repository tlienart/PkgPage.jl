using PkgPage
using Pkg
using Test
import Franklin
using FranklinUtils
using NodeJS
const P = PkgPage
const F = Franklin

m = F.newmodule(F.utils_name())
m.eval(Meta.parse("using PkgPage"))

include("latex/basic.jl")
include("latex/environments.jl")

include("instantiate.jl")
