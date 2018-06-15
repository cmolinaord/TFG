OUTPUT_DIR = pdf
SRC_DIR = tex
TEX = latexmk -cd- -pdf -outdir=$(OUTPUT_DIR) --shell-escape

.PHONY: all tfg tfg_prev clean clean_all count_words debug_label_chapters debug_warnings
.SILENT: all tfg_prev count_words debug_label_chapters debug_warnings debug_figures debug_figures_unused
.SILENT: list_bibliography_available list_bibliography_used

all:
	echo "make tfg:                          Compile the TFG from latex to pdf into pdf/ dir"
	echo "make tfg_prev:                     Show the TFG pdf result"
	echo "make clean:                        Remove the auxiliary files and logs in the output dir"
	echo "make clean_all:                    Remove all files in output dir, incluiding .pdf"
	echo "count_words:                       Count number of words in the whole document"
	echo "update_bibtex:                     Update the file of bibliography from mendeley database"
	echo "debug_warnings:                    Review '%WARNINGS' messages during the text put by the writer"
	echo "debug_figures:                     Show all the figures calls or references"
	echo "debug_figures_unused:              Show all the images in the repo that are not actually used in the document"
	echo "debug_label_chapters:              Show all the chapters that do not have a \label"
	echo "list_bibliography_available:       List all the entries in bibliography available in database"
	echo "list_bibliography_used:            List the actual bibliography referenced within the document"

#tfg
##############################
tfg: $(OUTPUT_DIR)/tfg.pdf

$(OUTPUT_DIR)/tfg.pdf: $(SRC_DIR)/tfg.tex
	mkdir -p $(OUTPUT_DIR)
	$(TEX) $(SRC_DIR)/tfg.tex

tfg_prev: tfg
	$(TEX) $(SRC_DIR)/tfg.tex -pv

# Miscelaneous
##############################

clean:
	rm $(OUTPUT_DIR)/*{aux,log,toc}

clean_all:
	rm $(OUTPUT_DIR)/*

count_words:
	pdftotext "$(OUTPUT_DIR)/tfg.pdf" - |grep -v "^[0-9]" | wc -w

update_bibtex:
	cp ~/.mendeley/TFG.bib doc/

debug_label_chapters:
	echo "Mostrando capitulos que no tienen ningun /label"
	grep -n -E '(\\chapter|\\(sub)*section)' $(SRC_DIR)/*.tex | grep -v -E '\\label' | sed 's/:/:\t/g'

debug_warnings:
	echo "Mostrando lineas con WARNINGS:"
	grep -n -A1 "^%WARNING" $(SRC_DIR)/*.tex | grep -v "WARNING" | sed 's/-%/: /'
	echo " "

debug_figures:
	echo "Mostrando todas las llamadas a etiquetas o referencias a figuras"
	grep -n "fig:" $(SRC_DIR)/*.tex

debug_figures_unused:
	./search_unused.sh

list_bibliography_available:
	cat doc/TFG.bib |grep ^@ |cut -d{ -f2 |cut -d, -f1

list_bibliography_used:
	grep -n "\cite" tex/*.tex
