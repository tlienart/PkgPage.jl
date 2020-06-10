module PackagePage

import Franklin
import CommonMark
import NodeJS

export serve, optimize

export lx_lead, lx_figure, lx_table
export lx_begin, lx_end, lx_column

export hfun_col

const F = Franklin

# Piracy
serve() = F.serve(clear=true)

# Should only be called in the deploy (on github-action)
function optimize()
    F.optimize(minify=false)
    js = """
        const PurgeCSS = require('purgecss');
        const result = await new PurgeCSS().purge({
            content: ['__site/index.html'],
            css: ['__site/css/bootstrap.min.css'],
            });
        fs = require('fs');
        fs.writeFile('__site/css/bootstrap.min.css', result.css);
        """
    run(`$(NodeJS.node_cmd()) -e '$js'`)
    return nothing
end


include("utils.jl")
include("coms/basic.jl")
include("coms/begin-end.jl")

end # module
