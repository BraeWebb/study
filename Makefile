# COURSES := $(wildcard */)
OUTPUT := out/
COURSES := comp4403 csse3100 coms3200
find_files := $(wildcard $(COURSE)/*.tex)
find_cheats := $(wildcard cheats/$(COURSE)/*.tex)

TEX=pdflatex
FLAGS=-shell-escape -interaction=batchmode -file-line-error

all: $(COURSES)
	@for course in $(COURSES); do \
		echo $${course}; \
		make build COURSE=$${course}; \
	done

build: $(find_files)
	make slide COURSE=$(COURSE)||true
	make pages COURSE=$(COURSE)||true
	make cheat COURSE=$(COURSE)

slide: slide.tex $(find_files)
	$(TEX) $(FLAGS) -output-directory=$(OUTPUT)/slides -jobname=$(COURSE) "\def\files{$(find_files)}\input slide"
	
pages: pages.tex $(find_files)
	$(TEX) $(FLAGS) -output-directory=$(OUTPUT)/pages -jobname=$(COURSE) "\def\files{$(find_files)}\input pages"

cheat: cheat.tex $(find_cheats)
	$(TEX) $(FLAGS) -output-directory=$(OUTPUT)/cheat -jobname=$(COURSE) "\def\files{$(find_cheats)}\input cheat"

