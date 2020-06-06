function _section(; title="", name=title)
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
        class = "class=\"bg-col-2\""
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
