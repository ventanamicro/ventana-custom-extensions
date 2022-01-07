SPEC=ventana-custom-extensions
DATE=$(shell date  +%Y%m%d)
VERSION=$(shell git describe --tag --always --dirty)

$(SPEC)-$(VERSION).pdf:  ventana-custom-extensions.adoc \
			 */*.adoc \
			 */insns/*.adoc \
			 resources/theme.yml
	asciidoctor-pdf -r asciidoctor-diagram \
			-D . \
			-a toc \
			-a compress \
			-a pdf-style=resources/theme.yml \
			-a pdf-fontsdir=resources/fonts \
			-a imagesoutdir=.images \
			-o $@ \
			$<
	gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -sOutputFile=opt-$@ $@ && mv opt-$@ $@

clean:
	rm -f $(SPEC)-*.pdf
