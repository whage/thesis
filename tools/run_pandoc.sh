pandoc \
    --bibliography=bibliography.bib \
    -o generated/thesis.html \
    --csl computing-surveys.csl \
    thesis.md \
    metadata.yaml
