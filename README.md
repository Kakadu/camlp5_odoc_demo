# camlp5 odoc demo

module A is preprocessed with camlp5, module B doesn't.

Both modules has doc inside mli's but for A's docs are not generated properly. I think because I can see (using `cat`) doc strings inside `_build/default/lib/.camlp5_odoc_demo.objs/byte/camlp5_odoc_demo__B_no_camlp5.cmti` but I can't read them from the contents of `_build/default/lib/.camlp5_odoc_demo.objs/byte/camlp5_odoc_demo__A_with_camlp5.cmti`. Sonething is wrong which lead to bad `*.cmti` generation.

### Getting a doc

    make doc # dune build @doc @doc-private --verbose

### viewing a doc 

    make view # xdg-open _build/default/_doc/_html/camlp5_odoc_demo/Camlp5_odoc_demo/A_with_camlp5/index.html


