<!--
The definitions here control the layout of the page: basic geometry, colors,
and elements. To avoid errors, do not remove definitions, possibly leave them
empty. Some definitions are only used if a toggle is set.

You can add your own rules if you so desire by either:
  - directly modifying `_css/custom.css`
  - adding rules to `_layout/style_tuning.fcss`
The latter allows you to plug in values that you would have defined here.
-->

<!-- META DEFINITIONS -->
@def title        = "YourPackage.jl"
@def description  = "Short description of your package"
@def authors      = "Grace Hopper, Rick Sanchez"
@def prepath      = "YourPackage.jl"
@def favicon_path = "/assets/favicon.ico"

<!--  NAVBAR SPECS
  NOTE:
  - add_docs:  whether to add a pointer to your docs website
  - docs_url:  the url of the docs website (ignored if add_docs=false)
  - docs_name: how the link should be named in the navbar

  - add_nav_logo:  whether to add a logo left of the package name
  - nav_logo_path: where the logo is
-->
@def add_docs  = true
@def docs_url  = "https://franklinjl.org/"
@def docs_name = "Docs"

@def add_nav_logo   = true
@def nav_logo_path  = "/assets/logo.svg"
@def nav_logo_alt   = "Logo"
@def nav_logo_style = """
        max-height:     25px;
        padding-right:  10px;"""

<!-- HEADER SPECS
  NOTE:
  - use_hero: if false, main bar stretches from left to right otherwise boxed
  - use_header_img: to use an image as background for the header
  - header_img_path: either a path to an asset or a SVG like here. Note that
        the path must be CSS-compatible.
  - header_img_style: additional styling, for instance whether to repeat
        or not. For a SVG pattern, use repeat, otherwise use no-repeat.
  - header_padding_top: vertical padding above the header, if over ~55px, there
        will be white space between the navbar and the header.
  - add_github_button: whether to add a "Star this package" button
  - github_repo: path to the github repo
-->

@def use_hero            = false
@def use_header_img      = true
@def header_img_path     = "url(\"../assets/diagonal-lines.svg\")"
@def header_img_style    = """
    background-repeat: repeat;
    """
@def header_padding_top  = "55px" <!-- 55 = touching nav bar -->
@def add_github_button   = true
@def github_repo         = "tlienart/Franklin.jl"

<!-- COLOR PALETTE
you can use Hex, RGB or SVG color names
These tools are useful:
  - color wheel: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Colors/Color_picker_tool
  - color names: https://developer.mozilla.org/en-US/docs/Web/CSS/color_value

Variables:
  - header_color: background color of the header
  - link_color: color of links
  - link_hover_color: color of links when hovered
  - section_bg_color: background color of "secondary" sections to help visually
        separate between sections.
  - footer_link_color: color of links in the footer
-->

    <!-- General layout -->
@def header_color       = "#3f6388"
@def link_color         = "#2669DD"
@def link_hover_color   = "teal"
@def section_bg_color   = "#f6f8fa"
@def footer_link_color  = "cornflowerblue"

    <!-- Code theme, pick from https://highlightjs.org/static/demo/
         examples (use lowercase and separate with `-`)
            * github
            * atom-one-dark
    -->
@def highlight_theme = "atom-one-dark"

    <!-- Tuning the appearance of code blocks
        * code_border_radius: increase for rounder corners
        * code_output_indent: left indent of output blocks
    -->
@def code_border_radius = "10px"
@def code_output_indent = "15px"


<!-- =======================================================================
============================================================================
DO NOT CHANGE THE FOLLOWING DEFINITIONS UNLESS YOU'RE SURE WHAT YOU'RE DOING
============================================================================
These definitions are important for the good functioning of some of the
commands that are defined and used in PackagePage.
-->
@def sections = Pair{String,String}[]
@def section_counter = 1
@def showall = true

\newcommand{\center}[1]{~~~<div style="text-align:center;">~~~#1~~~</div>~~~}
