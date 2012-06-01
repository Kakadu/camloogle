OCAMLINC=-I `ocamlc -where`/compiler-libs/parsing -I `ocamlc -where`/compiler-libs/utils
CMOS=warnings.cmo misc.cmo linenum.cmo location.cmo lexer.cmo longident.cmo \
	config.cmo clflags.cmo syntaxerr.cmo parser.cmo

all:
	eliomc  -c -noinfer $(OCAMLINC) extract.eliom
	eliomc  -c -noinfer ide.eliom
	eliomc  -c -noinfer app.eliom
	eliomc  -a -o var/app.cma $(OCAMLINC) $(CMOS) _server/extract.cmo _server/ide.cmo _server/app.cmo 
	eliomc  -infer app.eliom
	js_of_eliom -c ide.eliom
	js_of_eliom -o var/static/ide.js _client/ide.cmo
	js_of_eliom -c app.eliom
	js_of_eliom -o var/static/app.js _client/app.cmo

run:
	ocsigenserver -c ocsigen.conf


clean:
	rm -rf _client _server
