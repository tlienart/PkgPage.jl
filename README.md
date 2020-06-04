# PackagePage.jl

Create a webpage for your package in minutes.

**Authors**: Thibaut Lienart, Zlatan Vasović

## DEV

* Go to `/sandbox/` and start Franklin
* When we're happy  with  that, we'll re-structure where the different things are so that the `newpage` function puts files in the right place etc.

**Todo**
* [ ] think about standard use cases and add short example
  - inclusion of small, medium, large image
  - small grid of people
* [ ] make sure the instructions are dead simple
* [ ] add github workflow stuff with project by default
* [ ] fix prepath (project by default)
* [ ] indicate that this is expected to be hosted by github page
  - if not (self-hosted) need to do (a,b,c)

## Steps

Placeholder instructions, basically something like

```julia-repl
julia> using Pkg; Pkg.add(["Franklin", "PackagePage"])
julia> using Franklin; PackagePage
julia> newpage("PackageNamePage")
```

config, serve etc
