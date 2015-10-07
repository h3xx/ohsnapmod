BDFS := $(wildcard *.bdf)

PCFS := ${BDFS:.bdf=.pcf}

all: ${PCFS}

fonts.dir: ${PCFS} fonts.scale
	mkfontdir

fonts.scale: ${PCFS}
	mkfontscale

clean:
	rm -rf *.bak *-2x.bdf *.pcf fonts.dir fonts.scale

2x:
	for i in ${BDFS}; do bdfresize -f 2 "$$i" > $$(basename $$i .bdf)-2x.bdf; done

.SUFFIXES: .bdf .pcf

.bdf.pcf:
	bdftopcf -o $@ $<

.PHONY: all 2x
