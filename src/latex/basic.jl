"""
    \\lead{text}

A simple lead class div.
"""
lx_lead(com, _) = "@@lead $(lxproc(com)) @@"

"""
    \\alert{text}

A simple alert class div.
"""
function lx_alert(com, _)
    content = strip(lxproc(com))
    return html("""
        <div class="alert alert-info" role="alert">
        """) * content * html("</div>")
end

"""
    \\figure{path=..., alt=..., width=..., ...}

Insert a figure with kwargs specifications. See [`_figure`](@ref) for allowed specifications.
"""
function lx_figure(com, _)
    content = strip(lxproc(com))
    _, kwargs = lxargs(content, "figure")
    return _figure(; kwargs...)
end

function _figure(; path="", alt="", width="", style="",
                   caption="", imgclass="", captionclass="")
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
