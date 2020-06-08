"""
    proc(com)

Extract the content of a single-brace lx command. For instance `\\com{foo}`
would be extracted to `foo`.
"""
proc(com) = F.content(com.braces[1])


"""
    html(s)

Mark a string as HTML to be included in Franklin-markdown. Line spacing is
to reduce issues with `<p>`.
"""
html(s) = "\n~~~$s~~~\n"


"""
    lxargs(s)

Extract function-style arguments.
Expect (arg1, arg2, ..., name1=val1, name2=val2, ...)

Example:

    julia> a = ":section, 1, 3, title=\"hello\", name=\"bar\""
    julia> lxargs(a)
    (Any[:section, 1, 3], Any[:title => "hello", :name => "bar"])
"""
function lxargs(s, fname="")
    isempty(s) && return [], []
    s = "(" * s * ",)"
    args = nothing
    try
        args = Meta.parse(s).args
    catch
        error("A \\$fname{...} had improper specs:\n$s; verify.")
    end
    i = findfirst(e -> isa(e, Expr), args)
    if isnothing(i)
        cand_args = args
        cand_kwargs = []
    else
        cand_args = args[1:i-1]
        cand_kwargs = args[i:end]
    end
    proc_args   = []
    proc_kwargs = []
    for arg in cand_args
        if arg isa QuoteNode
            push!(proc_args, arg.value)
        else
            push!(proc_args, arg)
        end
    end
    for kwarg in cand_kwargs
        kwarg isa Expr || error("In \\$fname{...}, expected arguments " *
                                "followed by keyword arguments but got: " *
                                "$s; verify.")
        push!(proc_kwargs, kwarg.args[1] => kwarg.args[2])
    end
    return proc_args, proc_kwargs
end
