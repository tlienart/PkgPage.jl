const SUPPORTED_ENVS = (:section, :columns)

# NOTE: \begin{section} or \begin{:section} considered equiv.

function lx_begin(com, _)
    content = strip(proc(com))
    args, kwargs = lxargs(content, "begin")
    length(args) == 1 ||
        error("Expected a single argument such as `:section`.")
    env = args[1]
    env isa Symbol ||
        error("Expected a symbol as first argument such  as `:section`.")
    env in SUPPORTED_ENVS ||
        error("Unknown environment: $env.")
    starter = Symbol("_begin_$env")
    return eval(starter)(; kwargs...)
end

function lx_end(com, _)
    env = Symbol(strip(strip(proc(com)), ':'))
    env in SUPPORTED_ENVS ||
        error("Unknown environment: $env.")
    closer = Symbol("_end_$env")
    return eval(closer)()
end

#
# COLUMNS
#

_begin_columns() = html("""
    <div class="container">
      <div class="row">
    """)

_end_columns() = html("""
      </div>
    </div>
    """)

lx_column(com, _) = "@@col $(proc(com)) @@"

#
# SECTION
#

function _begin_section(; title="", name=title)
    id = F.refstring(name)
    pair = (id => name)
    if pair in F.locvar("sections")
        empty!(F.LOCAL_VARS["sections"].first)
    end
    push!(F.LOCAL_VARS["sections"].first, pair)
    counter = F.globvar("section_counter")
    F.set_var!(F.GLOBAL_VARS, "section_counter", counter+1)
    class = ""
    if iseven(counter)
        class = "class=\"section-bg-color\""
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

function _end_section()
    return html(
        """
              </div>
            </div>
          </div>
        </section>
        """)
end
