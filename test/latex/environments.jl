@testset "env_table" begin
    c = raw"""
        \begin{table}{caption="a table", class="table-striped"}
        | A   | B   |
        | --- | --- |
        | 0   | 1   |
        \end{table}""" |> F.fd2html
    @test isapproxstr(c, """
        <table class="table table-striped">
        <caption>a table</caption>
        <thead>
          <tr>
            <th align=\"left\">A</th>
            <th align=\"left\">B</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td align=\"left\">0</td>
            <td align=\"left\">1</td>
          </tr>
        </tbody>
        </table>""")
end

@testset "env_column" begin
    s = raw"""
        AB
        \begin{column}{}
        AAA
        \end{column}
        BA
        """ |> F.fd2html
    @test isapproxstr(s, """
        <p>AB</p>
        <div class="col "> AAA </div>
        <p>BA</p>
        """)
end

@testset "env_section" begin
    F.def_LOCAL_VARS!()
    F.def_GLOBAL_VARS!()
    F.LOCAL_VARS["sections"] = Pair{String,String}[] => (Pair{String,String},)
    F.GLOBAL_VARS["section_counter"] = 1 => (Int,)
    counter = F.globvar("section_counter")
    c = F.fd2html(raw"""
        \begin{section}{title="aaa"}
        Hello
        \end{section}
        """, internal=true)
    @test isapproxstr(c, """
        <section id="aaa" class="scrollspy">
          <div class="container">
            <div class="row">
              <div class="col-lg-10 mx-auto">
                <h2>aaa</h2>
                Hello
              </div>
            </div>
          </div>
        </section>
        """)
end
