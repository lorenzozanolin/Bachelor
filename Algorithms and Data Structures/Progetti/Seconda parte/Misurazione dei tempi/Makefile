# Bazzana Lorenzo, mat. 147569
# D'Ambrosi Denis, mat. 147681
# Zanolin Lorenzo, mat. 148199

# Questo è un semplice Makefile per costruire l'eesguibile per la registrazione dei tempi medi e ammortizzati di ricerca e inserimento in BST, AVL, RBT
# Eseguire make per compilare l'eseguibile
# Eseguire make clean_obj per eliminare solo i file oggetto creati durante la compilazione
# Eseguire make clean per eliminare sia i file oggetto che l'eseguibile finale 
getTimes : BST_trees.o AVL_trees.o RB_trees.o getTimes.o Trees_Operations.o trees.h
	clang++ -std=c++17 -g BST_trees.o AVL_trees.o RB_trees.o getTimes.o Trees_Operations.o -o getTimes


%.o : %.c trees.h
	g++  -std=c++17 -g -c -o $@ $<

clean_obj :
	rm -f *_trees.o Trees_Operations.o getTimes.o
clean :
	make clean_obj
	rm -f getTimes