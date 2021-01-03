# camlp5 odoc demo

Build the documentation:

    dune build @doc -w --verbose

In another tab:

    xdg-open _build/default/_doc/_html/libP5/LibP5__Extension/index.html

You can see two issues

* toplevel documentation for the module appears twice
* there is weird mangling of module names:

       module $Open__24_546 = Pcaml
       module $Open__25_557 = Stdlib.Printf
