pandoc -s -S \
    --latex-engine=xelatex \
    --bibliography=bibliography.bib \
    -o generated/thesis.pdf \
    --csl computing-surveys.csl \
    thesis.md \
    metadata.yaml \
    -V fontsize=12pt \
    -V mainfont="Times New Roman" \
    -V linestretch=1.15
