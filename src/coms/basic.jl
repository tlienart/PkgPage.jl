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
    style = ifelse(isempty(style), "", "style=\"$style\"")
    isempty(caption) ||
        (caption = "<figcaption class=\"figure-caption\">$caption</figcaption>")
    return html("""
        <figure class="figure">
          <img src="$path" alt="$alt" class="img-fluid" width="$width" $style>
          $caption
        </figure>
        """)
end
