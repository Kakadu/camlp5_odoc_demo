.PHONY: doc view

all:
	dune build --verbose

doc:
	dune build @doc @doc-private --verbose

clean:
	dune clean

view:
	xdg-open _build/default/_doc/_html/camlp5_odoc_demo/Camlp5_odoc_demo/B/index.html
	xdg-open _build/default/_doc/_html/camlp5_odoc_demo/Camlp5_odoc_demo/A/index.html
