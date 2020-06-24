.PHONY: doc view celan

all:
	dune build --verbose

doc:
	dune build @doc @doc-private --verbose

celan:
clean:
	dune clean

view:
	xdg-open _build/default/_doc/_html/camlp5_odoc_demo/Camlp5_odoc_demo/B_no_camlp5/index.html
	xdg-open _build/default/_doc/_html/camlp5_odoc_demo/Camlp5_odoc_demo/A_with_camlp5/index.html
