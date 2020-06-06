<!--
FILL THE FOLLOWING DEFINITIONS
-->
@def title       = "YourPackage.jl"
@def description = "Short description of your package"
@def authors     = "Grace Hopper, Rick Sanchez"

@def add_docs  = true
@def docs_url  = "https://franklinjl.org/"
@def docs_name = "Docs"

@def add_github_button = true
@def github_path       = "tlienart/Franklin.jl"

@def add_nav_logo   = true
@def nav_logo_path  = "/assets/logo.svg"
@def nav_logo_alt   = "Logo"
@def nav_logo_style = """
        max-height:     25px;
        padding-right:  5px;"""

<!--
COLOR PALETTE, ADJUST AS YOU WOULD LIKE
you can use hex, rgb or svg color names
These tools are useful:
 - color wheel: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Colors/Color_picker_tool
 - color names: https://developer.mozilla.org/en-US/docs/Web/CSS/color_value
-->
    <!-- General layout -->
@def header_col         = "#3f6388"
@def link_col           = "#2669DD"
@def link_hover_col     = "teal"
@def section_bg_col_2   = "#f6f8fa"
@def footer_link_col    = "cornflowerblue"

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

<!--
DO NOT CHANGE THE FOLLOWING DEFINITIONS
UNLESS YOU'RE SURE OF WHAT YOU'RE DOING

These definitions are important for the good functioning
of some of the commands that are defined and used in PackagePage.
-->
@def sections = Pair{String,String}[]
@def section_counter = 1
