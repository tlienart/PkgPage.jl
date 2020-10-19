using PkgPage
using Pkg
using Test
import Franklin
using FranklinUtils
using NodeJS
const P = PkgPage
const F = Franklin

F.newmodule("Utils")
Base.eval(Main.Utils, quote using PkgPage end)

include("latex/basic.jl")
include("latex/environments.jl")

include("instantiate.jl")
