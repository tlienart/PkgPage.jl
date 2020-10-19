# table
# column
# section

function env_column(e, _)
    md = F.content(e)
    _, kwargs = lxargs(lxproc(e), "column")
    return _column(md; kwargs...)
end

function _column(md; opts="")
    return html("<div class=\"col $opts\">") * md * html("</div>")
end

function env_table(e, _)
    md = F.content(e)
    _, kwargs = lxargs(lxproc(e), "table")
    return _table(md; kwargs...)
end

function _table(md; style="", caption="", class="")
    caption = ifelse(isempty(caption), "", "<caption>$caption</caption>")
    parser = CommonMark.Parser()
    CommonMark.enable!(parser, CommonMark.TableRule())
    h = CommonMark.html(parser(md))
    h = replace(h, "<table>"=>"")
    return html("""<table class="table $class">$caption $h""")
end

function env_section(e, _)
    md = F.content(e)
    _, kwargs = lxargs(lxproc(e), "section")
    return _section(md; kwargs...)
end

function _section(md; title="", name=title, width=F.globvar("section_width"))
    width = ifelse(isnothing(width), 10, width)
    id = F.refstring(name)
    pair = (id => name)
    if pair in F.locvar("sections")
        empty!(F.LOCAL_VARS["sections"].first)
    end
    push!(F.LOCAL_VARS["sections"].first, pair)
    counter = F.globvar("section_counter")
    F.set_var!(F.GLOBAL_VARS, "section_counter", counter+1)
    class = "scrollspy"
    if iseven(counter)
        class *= " section-bg-color"
    end
    return html("""
        <section id=\"$id\" class=\"$class\">
          <div class="container">
            <div class="row">
              <div class="col-lg-$width mx-auto">
                <h2>$title</h2>""") * md * html("""
              </div>
            </div>
          </div>
        </section>""")
end
