OUTPUT_DIR = pdf
SRC_DIR = tex
TEX = latexmk -cd- -pdf -outdir=$(OUTPUT_DIR) --shell-escape

.PHONY: all tfg tfg_prev clean clean_all count_words debug_label_chapters debug_warnings
.SILENT: all tfg_prev count_words debug_label_chapters debug_warnings

all:
	echo "make tfg:                          Compile the TFG from latex to pdf into pdf/ dir"
	echo "make tfg_prev:                     Show the TFG pdf result"
	echo "make clean:                        Remove the auxiliary files and logs in the output dir"
	echo "make clean_all:                    Remove all files in output dir, incluiding .pdf"

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
