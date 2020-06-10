<!-- =============================
     ABOUT
    ============================== -->

\begin{:section, title="About this Package", name="About"}

\lead{PackagePage.jl is based upon Franklin and makes it easy to create a beautiful landing page for a package in a few minutes.}

PackagePage uses a Bootstrap framework and is meant to be particularly easy to use with minimal need to tweak HTML or CSS to get a great-looking result.
With it you can:

* easily insert and style figures and tables,
* easily initiate a multi-columns environment,
* easily control the layout, colors, code theme etc from the config file,
* automatic insertion of new sections into the navbar,
* automatic purging of bootstrap css to remove unused rules,
* all the goodies from [Franklin.jl](https://github.com/tlienart/Franklin.jl):
    * live-rendering,
    * support for [KaTeX](https://github.com/KaTeX/KaTeX) and [highlight.js](https://highlightjs.org/) and automatic pre-rendering,
    * and [much more](https://franklinjl.org/).

\end{:section}

<!-- =============================
     GETTING STARTED
     ============================== -->
\begin{:section, title="Getting started"}

In order to get started, just add the package (with **Julia ≥ 1.3**) and

```julia-repl
julia> using PackagePage
julia> newpage()
julia> serve()
```

\\

The `newpage` call will
* generate a `page/` folder in your current directory which contains all the material to generate your site,
* place a `.github/workflows/DeployPage.yml` to enable the github action that will help deploy your page.

The `serve` call will render your page and make it available for live-preview in your browser.

\alert{You can specify another folder name via `newpage(path="page2")` but don't forget to modify this in the `DeployPage.yml` as well (in 2 spots).}

\end{:section}

<!-- =============================
     SPECIAL COMMANDS
     ============================== -->
\begin{:section, title="Commands"}

\lead{PackagePage makes a few commands available to you to simplify the insertion of common useful environments.
}

**Sections**: you can indicate a section as follows:

```plaintext
\begin{:section, opts...}
text
\end{:section}
```

where the available options are:

* `title="..."` to add a heading to the section, this should be provided,
* `name="..."` to add a specific name that will appear in the navbar (if not given, it will use the given title).

**Figures**: you can indicate a figure as follows:

```plaintext
\figure{path="...", opts...}
```

where `path` is a valid path to the image (e.g. `/assets/image.png`) and the other available options are:

* `width="..."` to specify the width of the image (e.g. `100%`),
* `alt="..."` to specify the image `alt`,
* `caption="..."` to specify the figure caption if any,
* `style="..."` to add any specific CSS styling to the image (e.g. `border-radius:5px`).

\center{
  \figure{path="/assets/nice_image.jpg", width="100%", style="border-radius:5px;", caption="Panoramic view of the Tara Cathedrals (taken from Wikimedia)."}
}

**Tables**: you can insert a table as follows:

```plaintext
\table{"""
| Column One | Column Two | Column Three |
|:---------- | ---------- |:------------:|
| Row `1`    | Column `2` |              |
| *Row* 2    | **Row** 2  | Column ``3`` |
""", opts...}
```

where the available options are:

* `caption="..."`: to add a caption to the table,
* `class="..."`: to add specific bootstrap classes to the table (e.g. `table-striped`),
* `style="..."`: for any further styling.

\center{
    \table{"""
    | Column One | Column Two | Column Three |
    |:---------- | ---------- |:------------:|
    | Row `1`    | Column `2` |              |
    | *Row* 2    | **Row** 2  | Column ``3`` |
    """, caption="A simple table", class="table-striped"}
}

**Columns**: you can declare an environment with columns with:

```plaintext
\begin{:columns}
\column{
Content of a first column  here
}
\column{
Content of a second column here
}
\end{:columns}
```

which will look like:

\begin{:columns}
\column{
_Content of a first column here_
}
\column{
_Content of a second column here_
}
\end{:columns}

\\

**Maths**

Just use `$$ ... $$` for display math and  `$ ... $` for inline maths:

$$ w_i = {2 \over (1-x_i^2)[P'_n(x_i)]^2} $$ <!--_-->

where $P_n$ is the $n$-th [Legendre polynomial](https://en.wikipedia.org/wiki/Legendre_polynomials) and $x_i$ is it's $i$-th root.

**Misc**

* you can use `\\` to add some vertical space (skip a line)
* you can use `\center{...}` to center some content
* you can use `\style{color:red;text-transform:capitalize;}{hello}` to get something like \style{color:red;text-transform:uppercase;}{hello},
* you can use `\alert{...}` to draw attention to some text via a coloured box.

You can also define your own commands which can be as complex as you might want, see the [Franklin docs](https://franklinjl.org) for more information.

\end{:section}

<!-- =============================
     Deploying
    ============================== -->

\begin{:section, title="Deployment"}

\lead{Make your page available online easily by leveraging github actions and GitHub pages.}

By following these instructions, the content of the rendered website will be copied to a `gh-pages` branch where it will be deployed by GitHub.
If you would like to deploy the page with your own URL or using something else than GitHub, have a  look at the specific instructions further on.

**Keys**: in order to have your page be built and deployed on GitHub, you will need to generate a keypair and add it to the GitHub repo. To do so:

1. run in your terminal  `ssh-keygen -N "" -f franklin`,
1. copy the entire content of  the `franklin` file and put it as a new secret named `FRANKLIN_PRIV` on <https://github.com/USERNAME/PACKAGE.jl/settings/secrets/new>,
1. copy the entire content of the  `franklin.pub` file and put it as a new deploy key named `FRANKLIN_PUB` on <https://github.com/USERNAME/PACKAGE.jl/settings/keys> with `read/write` access.

Whenever the `master` branch of your package gets updated, the  build process will be triggered and your page updated.
That's it.

**Avoiding clashes with Documenter.jl**: if you already use [Documenter.jl](https://github.com/JuliaDocs/Documenter.jl) you might want your page to be deployed in a specific folder of `gh-pages`.

\alert{Note that this is typically not necessary as the names created by PackagePage and by Documenter don't clash, but you might still prefer to not mix the two (in which case, read on).}

 you can do so in two steps:

1. change the `run` part of `DeployPage.yml` by specifying the `output` keyword argument  in `PackagePage.optimize` for instance: `PackagePage.optimize(input="page", output="page")`,
1. change the `prepath` in `config.md` to reflect that the base URL will contain that additional folder, for instance `@def prepath = "YourPackage.jl/page"`.

**Use your own URL**: you can usually get your host service like netlify to deploy a specific branch, do make sure to set `@def prepath = ""` in your `config.md` though.

\end{:section}

<!-- =============================
     SHOWING CODE
    ============================== -->

\begin{:section, title="Showing Code"}

\lead{
    Franklin can run your Julia code on the fly and show the output.
}

**Setting up the environment**: the first step is to ensure that the folder with your source has the proper environment including your package.
To do so, in the Julia REPL, navigate to the source (e.g. `cd("page/")`), activate the environment (e.g. `using Pkg; Pkg.activate()`) and add the package(s) that you need (e.g. `Pkg.add("DataFrames")`).
If you check the status or the Project.toml, you will see that `Franklin` is already in there on top of whatever packages you might have chosen to add.
In our current case:

```
Status `~/.julia/dev/PackagePage/page/Project.toml`
  [a93c6f00] DataFrames v0.21.2
  [713c75ef] Franklin v0.8.2
```

Also add the package in the `DeployPage.yml` e.g. in our case there is:

```julia
Pkg.add(["NodeJS", "DataFrames"]);
```

Once that's set up, you can use "named" code blocks i.e. code blocks that look like

`````
```julia:ex
using DataFrames
df = DataFrame(A = 1:4, B = ["M", "F", "F", "M"])
first(df, 3)
```
`````

where `:ex` is the "named part" (`ex` being the name, which should be unique on the page).

```julia:ex
using DataFrames
df = DataFrame(A = 1:4, B = ["M", "F", "F", "M"])
first(df, 3)
```

You can control the indentation and appearance of the output block in the `config.md` too.

\end{:section}
