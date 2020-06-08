"""
    \\lead{text}

A simple lead class.
"""
lx_lead(com, _) = "@@lead $(proc(com)) @@"

"""
    \\figure{path=..., alt=..., width=..., ...}

Insert a figure with specifications.
"""
function lx_figure(com, _)
    content = strip(proc(com))
    _, kwargs = lxargs(content, "figure")
    return _figure(; kwargs...)
end

function _figure(; path="", alt="", width="", style="", caption="")
    _style = ""
    isempty(width) || (_style *= "width:$width;")
    isempty(style) || (_style *= style)
    style = ifelse(isempty(_style), "", "style=\"$_style\"")
    isempty(caption) ||
        (caption = "<figcaption>$caption</figcaption>")
    return html("""
        <figure>
          <img src="$path" alt="$alt" class="img-fluid" $style/>
          $caption
        </figure>
        """)
end
