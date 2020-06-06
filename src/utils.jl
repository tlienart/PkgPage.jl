"""
    proc(com)

Extract the content of a single-brace lx command. For instance `\\com{foo}`
would be extracted to `foo`.
"""
proc(com) = F.content(com.braces[1])


"""
    html(s)

Mark a string as HTML to be included in Franklin-markdown. Line spacing is
to reduce issues with `<p>`.
"""
html(s) = "\n~~~$s~~~\n"
