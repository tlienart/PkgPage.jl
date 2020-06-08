@testset "lx_lead" begin
    c = lxc(raw"""\lead{Hello goodbye baz}""")
    @test lx_lead(c,0) == "@@lead Hello goodbye baz @@"
end

@testset "lx_figure" begin
    c = lxc(raw"""\figure{path="/assets/img.png"}""")
    @test isapproxstr(lx_figure(c,0), """~~~
        <figure>
          <img src=\"/assets/img.png\" alt=\"\" class=\"img-fluid\" />
        </figure>~~~""")
    c = lxc(raw"""\figure{path="/assets/img.png",width="100%",caption="foo"}""")
    @test isapproxstr(lx_figure(c,0), """~~~
        <figure>
          <img src=\"/assets/img.png\" alt=\"\" class=\"img-fluid\" style=\"width:100%;\"/>
          <figcaption>foo</figcaption>
        </figure>~~~""")
end
