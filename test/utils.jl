@testset "proc" begin
    c = lxc(raw"\foo{bar baz}")
    @test P.proc(c) == "bar baz"
end

@testset "html" begin
    @test P.html("aaa") == "\n~~~aaa~~~\n"
end

@testset "lxargs" begin
    s = """
        :section, 1, 3, title="hello", foo="bar", a=5
        """
    a, ka = P.lxargs(s)
    @test all(a .== (:section, 1, 3))
    @test all(ka .== (
        :title => "hello",
        :foo => "bar",
        :a => 5))
    s = """
        title=5, foo="bar"
        """
    a, ka = P.lxargs(s)
    @test isempty(a)
    @test all(ka .== (:title => 5, :foo => "bar"))
    s = """
        5, 3
        """
    a, ka = P.lxargs(s)
    @test isempty(ka)
    @test all(a .== (5, 3))
    # bad ordering
    s = """
        5, a=3, 2
        """
    @test_throws ErrorException P.lxargs(s)
end

@testset "invalid" begin
    c = lxc("""\\table{a:3}""")
    @test_throws Exception lx_table(c,0)
    c = lxc("""\\table{a=5}""")
    @test_throws Exception lx_table(c,0)
    c = lxc("""\\table{\"\"b}""")
    @test_throws Exception lx_table(c,0)
end
