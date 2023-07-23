@echo Started: %date% %time%
call asciidoctor-pdf  -a pdf-style=resources/pdfstyles/screen-theme.yml -a pdf-fontsdir=fonts book.adoc -o ORTS-CC-Notebook.pdf
@echo Ended: %date% %time% 


