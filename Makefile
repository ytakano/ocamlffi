all: prog

modcaml.o: mod.ml
	ocamlc -custom -output-obj -o modcaml.o mod.ml

modwrap.o: modwrap.c
	ocamlc -c modwrap.c

mod.a: modcaml.o modwrap.o
	cp `ocamlc -where`/libcamlrun.a mod.a
	chmod +w mod.a
	ar r mod.a modcaml.o modwrap.o

prog: mod.a
	cc -o prog -I `ocamlc -where` main.c mod.a -lcurses -ldl -lm

clean:
	rm -rf *.o *.cm* *.a prog
