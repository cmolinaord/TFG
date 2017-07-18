OUTPUT_DIR = pdf
SRC_DIR = tex
TEX = pdflatex -output-dir=$(OUTPUT_DIR)

.PHONY: all

all: memoria.pdf

preview:
	evince $(OUTPUT_DIR)/memoria.pdf

memoria.pdf: $(SRC_DIR)/memoria.tex
	$(TEX) $(SRC_DIR)/memoria.tex

clean:
	rm $(OUTPUT_DIR)/*{aux,log,toc}

clean_all:
	rm $(OUTPUT_DIR)/*
