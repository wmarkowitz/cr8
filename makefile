all: cr8 cr8_tests

cr8: cr8.ml
	ocamlbuild -use-ocamlfind cr8.byte

cr8_tests: cr8_tests.ml
	ocamlbuild -use-ocamlfind cr8_tests.byte


cr8_solutions: cr8_solutions.ml
	ocamlbuild -use-ocamlfind cr8_solutions.byte


clean:
	rm -rf _build *.byte