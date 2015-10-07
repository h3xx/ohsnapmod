srcdir := ohsnapmod

BDFS := \
	ohsnapmod7x12b.bdf \
	ohsnapmod7x12n.bdf \
	ohsnapmod7x14b.bdf \
	ohsnapmod7x14n.bdf \

PCFS := $(BDFS:.bdf=.pcf)

sfd2bdf := ./util/sfd2bdf

all: pcf

bdf: $(BDFS)

pcf: $(PCFS)

clean:
	$(RM) $(PCFS)

veryclean: clean
	$(RM) $(BDFS)

%.bdf: $(sfd2bdf)
	sz=$$(basename $@ .bdf |sed -e 's,^ohsnapmod\(.*\)$$,\1,') ;\
	ptsz=$$(echo $$sz |sed -e 's,^[0-9]x\(.*\)[a-z]$$,\1,') ;\
	inf=$(srcdir)/$$sz/$$(basename $@ .bdf).sfd ;\
	outf=$(srcdir)/$$sz/$$(basename $@ .bdf)-$$ptsz.bdf ;\
	$(sfd2bdf) $$inf ;\
	mv $$outf $@

%.pcf: %.bdf
	bdftopcf -o $@ $<

# these targets are mainly for testing

install: fonts.dir
	xset -fp $$PWD ;\
	xset +fp $$PWD ;\
	xset fp rehash


fonts.dir: $(PCFS) fonts.scale
	mkfontdir

fonts.scale: $(PCFS)
	mkfontscale

.PHONY: all clean install bdf pcf
