"""
    \\lead{...}

A simple lead class.
"""
function lx_lead(com, _)
    txt = proc(com)
    return html("<div class=\"lead\">") * txt * html("</div>")
end
