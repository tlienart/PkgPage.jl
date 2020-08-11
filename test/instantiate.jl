@testset "instantiation" begin
    sandbox = mktempdir(); bk = pwd(); cd(sandbox)

    @testset "newpage" begin
        mkdir("foo")
        newpage(path="foo", overwrite=true)
        @test isdir("foo")
        @test isdir(joinpath("foo", "_layout"))
        @test isfile(joinpath("foo", "config.md"))
        @test isfile(joinpath("foo", "index.md"))
        @test isfile(joinpath(".github", "workflows", "DeployPage.yml"))
    end

    @testset "cd" begin
        bk, outside = PkgPage.clever_cd("foo")
        @test endswith(bk, sandbox)
        @test outside
        @test !isdir("foo")
        bk, outside = PkgPage.clever_cd("foo")
        @test !outside
        cd("..")
    end

    @testset "serve" begin
        @test_throws Exception serve(; single=true)
        serve("foo"; single=true)
        @test isdir(joinpath("foo", "__site"))
        @test isfile(joinpath("foo", "__site", "index.html"))
        @test endswith(pwd(), sandbox)
    end

    @testset "optimize" begin
        PkgPage.optimize(; input="foo", output="bar", purge=false,
                           prerender=false)
        @test readdir(joinpath("foo", "__site")) == ["bar"]
        @test isfile(joinpath("foo", "__site", "bar", "index.html"))
    end
    cd(bk)
    Pkg.activate()
end
