proc(com) = Franklin.content(com.braces[1])
html(s) = "\n~~~$s~~~\n"

function lx_lead(com, _)
    txt = proc(com)
    return html("<p class=\"lead\">") * txt * html("</p>")
end

function lx_begin(com, _)
    content = strip(proc(com))
    isempty(content) && return ""
    content = "(" * content * ")"
    try
        args = Meta.parse(content).args
    catch
        error("A \\begin{...} had improper specs:\n$content; verify.")
    end
    @assert args[1] isa QuoteNode
    env = args[1].value
    @assert env isa Symbol "Expected a symbol as first field"
    @assert env in (:section,) "Unknown environment: $env."
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
    env == :section && return _section(; args...)
end

function lx_end(com, _)
    env = Symbol(strip(strip(proc(com)), ':'))
    @assert env in (:section,) "Unknown environment: $env."
    env == :section && return _end_section()
end

function _section(; id="", name=uppercasefirst(id), title="")
    pair = (id => name)
    if pair in locvar("sections")
        empty!(Franklin.LOCAL_VARS["sections"].first)
    end
    push!(Franklin.LOCAL_VARS["sections"].first, pair)
    counter = globvar("section_counter")
    class = ""
    if iseven(counter)
        class = "class=\"bg-light\""
    end
    return html(
        """
        <section id=\"$id\" $class>
          <div class="container">
            <div class="row">
              <div class="col-lg-8 mx-auto">
                <h2>
                  $title
                </h2>
        """)
end

_end_section() = html(
        """
              </div>
            </div>
          </div>
        </section>
        """)
#
# function lx_section(com, _)
#     counter = globvar("section_counter")
#     Franklin.set_var!(Franklin.GLOBAL_VARS, "section_counter", counter+1)
#     brace_content = proc(com)
#     # "User base => parts/users.mkd"
#     #   name -- "User base"
#     #   fpath -- "parts/users.mkd"
#     #   short -- "users"
#     name, fpath = strip.(split(brace_content, "=>"))
#     short = splitext(splitdir(fpath)[2])[1]
#     # keep track of it for the navbar
#     push!(Franklin.GLOBAL_VARS["sections"].first, short => name)
#     # check if the file exists otherwise show something ugly
#     isfile(fpath) || return """
#         \\style{color:red;font-weight:bold;}{File $fpath doesn't exist.}"""
#     # read and write appropriate html
#     input = read(fpath, String)
#     class = ""
#     if iseven(counter)
#         class = "class=\"bg-light\""
#     end
#     top =  html("""
#                 <section id=\"$short\" $class>
#                   <div class="container">
#                     <div class="row">
#                       <div class="col-lg-8 mx-auto">
#                 """)
#     bottom = html("""
#                       </div>
#                     </div>
#                   </div>
#                 </section>""")
#     return top * input * bottom
# end
