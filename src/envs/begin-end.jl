const SUPPORTED_ENVS = (:section, :columns)

function lx_begin(com, _)
    content = strip(proc(com))
    isempty(content) && return ""
    content = "(" * content * ",)"
    try
        args = Meta.parse(content).args
    catch
        error("A \\begin{...} had improper specs:\n$content; verify.")
    end
    @assert args[1] isa QuoteNode
    env = args[1].value
    @assert env isa Symbol "Expected a symbol as first field"
    @assert (env in SUPPORTED_ENVS) "Unknown environment: $env."
    env == :columns && @goto switch

    # KWARGS
    names = []
    vals = []
    if length(args) > 1
        for arg in args[2:end]
            @assert arg isa Expr
            name = arg.args[1]
            @assert name isa Symbol
            push!(names, name)
            push!(vals, arg.args[2])
        end
    end
    args = NamedTuple{tuple(names...)}(vals)

    @label switch
    env == :section && return _section(; args...)
    env == :columns && return _columns()
end

function lx_end(com, _)
    env = Symbol(strip(strip(proc(com)), ':'))
    @assert env in SUPPORTED_ENVS "Unknown environment: $env."
    env == :section && return _end_section()
    env == :columns && return _end_columns()
end
