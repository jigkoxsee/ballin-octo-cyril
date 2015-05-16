comp: comp.y comp.l
	bison -d comp.y
	flex  comp.l
	g++ comp.tab.c lex.yy.c -lfl -o out.comp -g
clean:
	$(RM) comp.tab.c comp.tab.h lex.yy.c out.comp
