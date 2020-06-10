# Piracy to avoid code caching and reduce risks of silly
# errors and hard-to-understand error messages.
function serve(path="page")
    isdir(path) || error("Couldn't find path '$path'.")
    bk = pwd()
    cd(path)
    try
        F.serve(clear=true)
    catch e
        @show e
    finally
        cd(bk)
    end
    return nothing
end

# Should only be called in the deploy (on github-action)
function optimize(; input="page", output="")
    isdir(input) || error("Couldn't find the folder '$input'.")
    occursin("/", output) && error("No depth allowed in output.")
    bk = pwd()
    cd(input)
    F.optimize(minify=false)
    # Purge CSS to decrease bootstrap size massively
    io = IOBuffer()
    run(pipeline(`$(NodeJS.npm_cmd()) root`, stdout=io))
    nodepath = String(take!(io))
    run(`$(strip(nodepath))/purgecss/bin/purgecss --css __site/css/bootstrap.min.css --content __site/index.html --output __site/css/bootstrap.min.css`)

    isempty(output) && (cd(bk); return nothing)

    # copy the content of `__site` to `__site/$output`, it's
    # the user's responsibility to check this is valid (i.e. that
    # there isn't already a folder $output...)
    outp = mkpath(joinpath("__site", output))
    for obj in readdir("__site")
        obj == output && continue
        src = joinpath("__site", obj)
        dst = joinpath(outp, obj)
        mv(src, dst; force=true)
    end
    cd(bk)
    return nothing
end

"""
    newpage()
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
    store = joinpath(dirname(pathof(PackagePage)), "web")
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
    cp(src, dst, force=false)
    chmod(dst, 0o644)
    return nothing
end
