#
# Stupid way to recreate a com so that
# can test com extractors
#

lxd(n) = F.LxDef("\\" * n, 1, F.subs(""))

function lxc(mds)
    F.def_GLOBAL_LXDEFS!()
    empty!(F.GLOBAL_LXDEFS)
    name = match(r"\\(.*?)\{", mds).captures[1]
    F.GLOBAL_LXDEFS[name] = lxd(name)
    tokens = F.find_tokens(mds, F.MD_TOKENS, F.MD_1C_TOKENS)
    blocks, tokens = F.find_all_ocblocks(tokens, F.MD_OCB2)
    lxdefs, tokens, braces, _ = F.find_lxdefs(tokens, blocks)
    lxdefs = cat(collect(values(F.GLOBAL_LXDEFS)), lxdefs, dims=1)
    lxcoms, _ = F.find_lxcoms(tokens, lxdefs, braces)
    return lxcoms[1]
end


F.LOCAL_VARS["sections"] = Pair{String,String}[] => (Pair{String,String},)
F.GLOBAL_VARS["section_counter"] = 1 => (Int,)


isapproxstr(s1, s2) =
    isequal(map(s->replace(s, r"\s|\n"=>""), String.((s1, s2)))...)
