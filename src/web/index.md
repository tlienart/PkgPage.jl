<!-- =============================
     ABOUT
     NOTE: title is what appears at the top of the section, the name is
     what appears in the navbar; if not provided it will be the same as the
     title.
    ============================== -->

\begin{:section, title="About this Package", name="About"}

\lead{This is a great place to talk about your webpage. This template is purposefully unstyled so you can use it as a boilerplate or starting point for you own landing page designs!}

* Some information [a link](https://julialang.org)
* Minimal custom CSS blah so you are free to explore your own unique design options

\figure{
    path="data:image/gif;base64,R0lGODlhAQABAIAAAMLCwgAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==",
    width=200,
    caption="Placeholder image"
}

\end{:section}

<!-- =============================
     SHORT INTRO
     NOTE: "named" julia code (eg `julia:usage1`) gets executed on the fly
     and the output can be shown with `\show{usage1}`.
    ============================== -->
\begin{:section, title="Usage"}

\lead{This is a short example of how you can use the amazing package}

<!-- NOTE:  if you want a  code block to be executed and its output to
    be shown, you must "name" it so  use ```julia:name rather  than just
    ```julia see example below.
    The name must be a unique identifier on the page -->

```julia:usage1
using DataFrames
df = DataFrame(A = 1:4, B = ["M", "F", "F", "M"])
first(df, 3)
```

More explanations here if useful.

\end{:section}

<!-- =============================
     BACKGROUND
     NOTE: Maths are rendered with KaTeX and can be written as you would
     standard LaTeX (mostly).
    ============================== -->
\begin{:section, title="Background"}

\lead{This package provides support for one-dimensional integration in Julia using Gauss-Kronrod quadrature.}

The problem, amounts to approximating an integral using a weighted sum of function evaluations:

$$ \int_a^b f(x) \mathrm{d}x \approx \sum_{i=1}^n w_i f(x_i) $$

In the case of the Gauss-Legendre quadrature, the weights are given by

$$ w_i = {2 \over (1-x_i^2)[P'_n(x_i)]^2} $$ <!--_-->

where $P_n$ is the $n$-th [Legendre polynomial](https://en.wikipedia.org/wiki/Legendre_polynomials) and $x_i$ is it's $i$-th root.

\end{:section}

<!-- =============================
     PERFORMANCES
    ============================== -->

\begin{:section, title="Performances"}

\lead{A great place to tell people about the amazing performances of your package}

Here are not one but **two** columns!

\begin{:columns}

\column{
* it's much faster than python
* definitely faster
* so much faster
}
\column{
* still better than python
* definitely better than R
}

\end{:columns}

You can also have tables:

\table{"""
| Column One | Column Two | Column Three |
|:---------- | ---------- |:------------:|
| Row `1`    | Column `2` |              |
| *Row* 2    | **Row** 2  | Column ``3`` |
""", class="table-striped", caption="a table"}

\end{:section}

<!-- =============================
     USER BASE
    ============================== -->

\begin{:section, title="User base"}

\lead{All these good people use the package! Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vero odio fugiat voluptatem dolor, provident officiis, id iusto! Obcaecati incidunt, qui nihil beatae magnam et repudiandae ipsa exercitationem, in, quo totam.}

* Person A
* Person B

\end{:section}
