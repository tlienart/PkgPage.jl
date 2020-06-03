html(s) = "~~~$s~~~"

function lx_section(com, _)
    counter = globvar("section_counter")
    Franklin.set_var!(Franklin.GLOBAL_VARS, "section_counter", counter+1)
    brace_content = Franklin.content(com.braces[1])
    name, fpath = strip.(split(brace_content, ':'))
    isfile(fpath) || return """
        \\style{color:red;font-weight:bold;}{File $fpath doesn't exist.}"""
    input = read(fpath, String)
    class = ""
    if iseven(counter)
        class = "class=\"bg-light\""
    end
    top =  html("""
                <section id=\"$name\" $class>
                  <div class="container">
                    <div class="row">
                      <div class="col-lg-8 mx-auto">
                \n""")
    bottom = html("""\n
                      </div>
                    </div>
                  </div>
                </section>""")
    return top * input * bottom
end

function lx_lead(com, _)
    txt = Franklin.content(com.braces[1])
    return html("<p class=\"lead\">") * txt * html("</p>")
end
