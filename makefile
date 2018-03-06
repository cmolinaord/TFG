OUTPUT_DIR = pdf
SRC_DIR = tex
TEX = pdflatex -output-dir=$(OUTPUT_DIR)

.PHONY: all preview clean clean_all count_words

all: main.pdf

preview:
	evince $(OUTPUT_DIR)/main.pdf

main.pdf: $(SRC_DIR)/main.tex
	mkdir -p $(OUTPUT_DIR)
	$(TEX) $(SRC_DIR)/main.tex

clean:
	rm $(OUTPUT_DIR)/*{aux,log,toc}

clean_all:
	rm $(OUTPUT_DIR)/*

count_words:
	pdftotext "$(OUTPUT_DIR)/main.pdf" - |grep -v "^[0-9]" | wc -w

debug_label_chapters:
	echo "Mostrando capitulos que no tienen ningun /label"
	cat $(SRC_DIR)/*.tex | grep -E '(\\chapter|\\section)' | grep -v -E '\\label'
