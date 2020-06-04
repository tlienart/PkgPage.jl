proc(com) = Franklin.content(com.braces[1])
html(s) = "\n~~~$s~~~\n"

function lx_section(com, _)
    counter = globvar("section_counter")
    Franklin.set_var!(Franklin.GLOBAL_VARS, "section_counter", counter+1)
    brace_content = proc(com)
    # "User base => parts/users.mkd"
    #   name -- "User base"
    #   fpath -- "parts/users.mkd"
    #   short -- "users"
    name, fpath = strip.(split(brace_content, "=>"))
    short = splitext(splitdir(fpath)[2])[1]
    # keep track of it for the navbar
    push!(Franklin.GLOBAL_VARS["sections"].first, short => name)
    # check if the file exists otherwise show something ugly
    isfile(fpath) || return """
        \\style{color:red;font-weight:bold;}{File $fpath doesn't exist.}"""
    # read and write appropriate html
    input = read(fpath, String)
    class = ""
    if iseven(counter)
        class = "class=\"bg-light\""
    end
    top =  html("""
                <section id=\"$short\" $class>
                  <div class="container">
                    <div class="row">
                      <div class="col-lg-8 mx-auto">
                """)
    bottom = html("""
                      </div>
                    </div>
                  </div>
                </section>""")
    return top * input * bottom
end

function lx_lead(com, _)
    txt = proc(com)
    return html("<p class=\"lead\">") * txt * html("</p>")
end
