"""
    newpage()

Create a new package page.

Arguments:
* `path="page"`: the folder to place the source files of your site; these
                 are the markdown files and configuration files you will need
                 to adjust based on which your website will be generated.
* `overwrite=false`: whether to overwrite the folder if it already exists.
"""
function newpage(; path="page", overwrite=false)
    if isdir(path)
        if !overwrite
            error("Path '$path' already exists, use `overwrite=true` " *
                  "if you wish to remove that folder and start again.")
        else
            rm(path, recursive=true)
        end
    end
    mkdir(path)
    store = joinpath(dirname(dirname(pathof(PkgPage))), "page")
    for obj in readdir(store)
        obj == "DeployPage.yml" && continue
        src = joinpath(store, obj)
        dst = joinpath(path, obj)
        cp(src, dst)
    end
    # Pkg makes files read-only but we don't want that
    for (root, _, files) ∈ walkdir(path)
        for file in files
            chmod(joinpath(root, file), 0o644)
        end
    end

    # Try placing the `DeployPage.yml`
    name = "DeployPage.yml"
    gapath = mkpath(joinpath(".github", "workflows"))
    src = joinpath(store, name)
    dst = joinpath(gapath, name)
    cp(src, dst, force=overwrite)
    chmod(dst, 0o644)
    return nothing
end

function clever_cd(path)
    # try to be clever, in some circumstances, we might be in the "page"
    # folder where this expects us to be one level up; if that's the case
    # don't move.
    # cases covered:
    #   1. we're at the proper level, cd serve & cd back
    #   2. we're in the folder, don't cd and serve
    #   3. user is somewhere else --> error
    bkpath  = pwd()
    inside  = isfile("config.md") && isdir("_layout")
    outside = !inside && isdir(path)
    if !(inside || outside)
        error("Your current path does not seem to contain content for a " *
              "package page that matches `path=$path`; maybe you forgot to " *
              "call `instantiate`?")
    end
    outside && cd(path)
    return (bkpath, outside)
end

# Piracy to avoid code caching and reduce risks of silly
# errors and hard-to-understand error messages.
function serve(path="page"; kw...)
    bkpath, outside = clever_cd(path)
    try
        F.serve(clear=true; kw...)
    catch e
        @show e
    finally
        outside && cd(bkpath)
    end
    return nothing
end

# Should only be called in the deploy (by github-action) or via `publish`
# assumes that `purgecss` is available to NodeJS.
function optimize(; input="page", output="", purge=true, kw...)
    occursin("/", output) &&
        error("No depth allowed in `output`: it should either be an " *
              "empty string or something like `web` or `page`.")
    bkpath, outside = clever_cd(input)

    # Optimization phase
    F.optimize(; minify=false, kw...)

    if purge
        # Purge CSS to decrease bootstrap size massively
        io = IOBuffer()
        run(pipeline(`$(NodeJS.npm_cmd()) root`, stdout=io))
        nodepath = String(take!(io))
        run(`$(strip(nodepath))/purgecss/bin/purgecss --css __site/css/bootstrap.min.css --content __site/index.html --output __site/css/bootstrap.min.css`)
    end

    # if required, copy the content of `__site` to a subfolder so that
    # that subfolder can be deployed. It's the user's responsibility to
    # ensure that there isn't already a folder $output.
    if !isempty(output)
        outp = mkpath(joinpath("__site", output))
        for obj in readdir("__site")
            obj == output && continue
            src = joinpath("__site", obj)
            dst = joinpath(outp, obj)
            mv(src, dst; force=true)
        end
    end
    outside && cd(bkpath)
    return nothing
end
