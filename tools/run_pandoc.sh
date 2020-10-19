pandoc -s -S \
    --bibliography=bibliography.bib \
    -o generated/thesis.pdf \
    --csl computing-surveys.csl \
    thesis.md \
    metadata.yaml
