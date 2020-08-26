"""
    \\lead{text}

A simple lead class.
"""
lx_lead(com, _) = "@@lead $(lxproc(com)) @@"

"""
    \\figure{path=..., alt=..., width=..., ...}

Insert a figure with specifications.
"""
function lx_figure(com, _)
    content = strip(lxproc(com))
    _, kwargs = lxargs(content, "figure")
    return _figure(; kwargs...)
end

function _figure(; path="", alt="", width="", style="", caption="", imgclass="", captionclass="")
    style = ifelse(isempty(style), "", "style=\"$style\"")
    if !isempty(caption)
        isempty(alt) && (alt = caption)
        caption = """
            <figcaption class="figure-caption $captionclass">
            $caption
            </figcaption>
            """
    end
    return html("""
        <figure class="figure">
          <img src="$path" alt="$alt" class="figure-img img-fluid $imgclass" width="$width" $style>
          $caption
        </figure>
        """)
end

"""
    \\table{..., opt1=...}

Insert a table with specifications.
"""
function lx_table(com, _)
    content = strip(lxproc(com))
    args, kwargs = lxargs(content, "table")
    length(args) == 1 ||
        error("Expected a single un-named argument for `\\table`.")
    return _table(args[1]; kwargs...)
end

function _table(md; style="", caption="", class="")
    caption = ifelse(isempty(caption), "", "<caption>$caption</caption>")
    parser = CommonMark.Parser()
    CommonMark.enable!(parser, CommonMark.TableRule())
    h = CommonMark.html(parser(md))
    h = replace(h, "<table>"=>"")
    return html("""<table class="table $class">$caption $h""")
end

function lx_alert(com, _)
    content = strip(lxproc(com))
    return html("""
        <div class="alert alert-info" role="alert">
        """) * content * html("</div>")
end
