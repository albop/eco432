#!/usr/bin/bash 
pandoc -t beamer -f markdown+implicit_figures index.md -o index.pdf --pdf-engine=xelatex --slide-level=3 --metadata=options
