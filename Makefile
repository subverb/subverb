
PREFIX?=/usr
BINDIR?=$(PREFIX)/bin

INSTALL?=install
EXECMODE?=0755
FILEMODE?=0644
DIRMODE?=0755

PROGRAMS=subverb

TESTS=$(patsubst t/%.tmk,%,$(sort $(wildcard t/*.tmk)))

all:

check: $(addprefix check-,$(TESTS))

install: $(addprefix install-exec-,$(PROGRAMS))

install-exec-%: install-dirs
	$(INSTALL) -m $(EXECMODE) $*  $(BINDIR)

install-dirs:
	$(INSTALL) -m $(DIRMODE) -d $(BINDIR)

check-%:
	$(MAKE) -C t -f $(@:check-%=%.tmk) TOPDIR=.. check

clean: TESTBASE=$(addprefix t/., $(TESTS))
clean:
	for i in $(TESTS); do test -L t/$$i && rm t/$$i; done; true
	rm -f $(addsuffix .res, $(TESTBASE)) $(addsuffix .ref, $(TESTBASE))

.PHONY: all check install install-exec-% install-dirs check-%
