pdf2md
======

Steps to un-scramble a BullsZIP PDF using KaiU font:

1. pdf2htmlex --no-drm 1 --embed-font=0 --font-format svg FILENAME.pdf
2. Replace the `f1.svg` in this directory with the generated one
3. pdf2json -f FILENAME.pdf
4. perl build.pl > output.json

TODO: Take the JSON and generate CSV or MD from it.
