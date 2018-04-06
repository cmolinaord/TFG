OUTPUT_DIR = pdf
SRC_DIR = tex
TEX = pdflatex -output-directory=$(OUTPUT_DIR)

.PHONY: all tfg tfg_prev clean clean_all count_words
.SILENT: all tfg_prev count_words debug_label_chapters

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
	latexmk -cd- -pdf -outdir=$(OUTPUT_DIR) $(SRC_DIR)/tfg.tex

tfg_prev: tfg
	evince $(OUTPUT_DIR)/tfg.pdf &

# Miscelaneous
##############################

clean:
	rm $(OUTPUT_DIR)/*{aux,log,toc}

clean_all:
	rm $(OUTPUT_DIR)/*

count_words:
	pdftotext "$(OUTPUT_DIR)/tfg.pdf" - |grep -v "^[0-9]" | wc -w

debug_label_chapters:
	echo "Mostrando capitulos que no tienen ningun /label"
	cat $(SRC_DIR)/*.tex | grep -E '(\\chapter|\\section)' | grep -v -E '\\label'
