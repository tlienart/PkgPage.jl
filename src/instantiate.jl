const VALUE_REGEX = r"{{\s*(?<name>[a-z_]+)\s*}}"

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

#=
    DEFAULT fill functions for config.md
=#
fill_default(::Val{:title}) = "YourPackage.jl"
fill_default(::Val{:authors}) = "Grace Hopper, Rick Sanchez"
fill_default(::Val{:docs_url}) = "https://franklinjl.org/"
fill_default(::Val{:github_repo}) = "tlienart/Franklin.jl"

fill(v::SubString) = fill(Val(Symbol(v)))
fill(v) = fill_default(v)

function fill(v::Val{:title})
    if isfile("Project.toml")
        toml_dir = TOML.parsefile("Project.toml")
        if haskey(toml_dir, "name")
            return toml_dir["name"]
        end
    end
    return fill_default(v)
end


function fill(v::Val{:authors})
    if isfile("Project.toml")
        toml_dir = TOML.parsefile("Project.toml")
        if haskey(toml_dir, "authors")
            # remove
            authors = toml_dir["authors"]
            # remove email addresses
            for i = 1:length(authors)
                authors[i] = strip(replace(authors[i], r"<(.*?)>" => ""))
            end
            return join(authors, ", ")
        end
    end
    return fill_default(v)
end

function fill(v::Val{:docs_url})
    try 
        git_remote = LibGit2.get(GitRemote, GitRepo(pwd()), "origin")
        url = LibGit2.url(git_remote)
        m = match(r"github\.com\/(?<user>.*?)\/(?<repo>.*?)(\.git)", url)
        docs_url = "https://$(m[:user]).github.io/$(m[:repo])/stable/"
        return docs_url
    catch e 
        return fill_default(v)
    end
end

function fill(v::Val{:github_repo})
    try 
        git_remote = LibGit2.get(GitRemote, GitRepo(pwd()), "origin")
        url = LibGit2.url(git_remote)
        url = replace(url, r"https?://github\.com\/" => "")
        url = replace(url, r"\.git$" => "")
        return url
    catch 
        return fill_default(v)
    end
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
    store = joinpath(dirname(pathof(PkgPage)), "web")
    for obj in readdir(store)
        obj == "DeployPage.yml" && continue
        obj == "config.md" && continue
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
    # Try filling `config.md`
    name = "config.md"
    src = joinpath(store, name)
    config = read(src, String)
    dst = joinpath(path, name)
    config = replace(config, VALUE_REGEX => s->match(VALUE_REGEX, s)[:name] |> fill)
    write(dst, config)

    # Try placing the `DeployPage.yml`
    name = "DeployPage.yml"
    gapath = mkpath(joinpath(".github", "workflows"))
    src = joinpath(store, name)
    dst = joinpath(gapath, name)
    cp(src, dst, force=false)
    chmod(dst, 0o644)
    return nothing
end
