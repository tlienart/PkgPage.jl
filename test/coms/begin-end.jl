@testset "invalid" begin
    c = lxc(raw"""\begin{:sectiom}""")
    @test_throws ErrorException lx_begin(c,0)
end

@testset "section" begin
    counter = F.globvar("section_counter")
    c = lxc(raw"""\begin{:section, title="aaa"}""")
    h = lx_begin(c,0)
    @test F.globvar("section_counter") == counter + 1
    @test isapproxstr(strip(h), """
        ~~~<section id="aaa" class="scrollspy">
          <div class="container">
            <div class="row">
              <div class="col-lg-8 mx-auto">
                <h2>
                  aaa
                </h2>
        ~~~""")
    c = lxc(raw"""\end{:section}""")
    h = lx_end(c,0)
    @test isapproxstr(h, """~~~
                </div>
              </div>
            </div>
          </section>
          ~~~""")
end

@testset "columns" begin
    c = lxc(raw"""\begin{:columns}""")
    h = lx_begin(c,0)
    @test isapproxstr(h, """~~~
        <div class=\"container\">
          <div class=\"row\">
        ~~~""")
    c = lxc(raw"""\end{:columns}""")
    h = lx_end(c,0)
    @test isapproxstr(h, """~~~
        </div></div>
        ~~~""")
end
