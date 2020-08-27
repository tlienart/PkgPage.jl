@testset "invalid" begin
    c = lxmock(raw"""\begin{:sectiom}""")
    @test_throws ErrorException lx_begin(c,0)
end

@testset "section" begin
    counter = F.globvar("section_counter")
    c = lxmock(raw"""\begin{:section, title="aaa"}""")
    h = lx_begin(c,0)
    @test F.globvar("section_counter") == counter + 1
    @test isapproxstr(strip(h), """
        ~~~<section id="aaa" class="scrollspy">
          <div class="container">
            <div class="row">
              <div class="col-lg-10 mx-auto">
                <h2>
                  aaa
                </h2>
        ~~~""")
    c = lxmock(raw"""\end{:section}""")
    h = lx_end(c,0)
    @test isapproxstr(h, """~~~
                </div>
              </div>
            </div>
          </section>
          ~~~""")
end

@testset "columns" begin
    c = lxmock(raw"""\begin{:columns}""")
    h = lx_begin(c,0)
    @test isapproxstr(h, """~~~
        <div class=\"container\">
          <div class=\"row\">
        ~~~""")
    c = lxmock(raw"""\end{:columns}""")
    h = lx_end(c,0)
    @test isapproxstr(h, """~~~
        </div></div>
        ~~~""")
end
