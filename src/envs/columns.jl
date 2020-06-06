function _columns(; ncols=2)
    return html(
    """
    <div class="container">
      <div class="row">
    """)
end

function _end_columns()
    return html(
    """
      </div>
    </div>
    """)
end


function lx_column(com, _)
    cont = proc(com)
    return "@@col $cont @@"
end
