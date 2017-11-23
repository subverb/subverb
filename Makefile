
PREFIX?=/usr
BINDIR?=$(PREFIX)/bin

INSTALL?=install
EXECMODE?=0755
FILEMODE?=0644
DIRMODE?=0755

PROGRAMS=subverb

all:

check: $(patsubst t/%.tmk,check-%,$(wildcard t/*.tmk))

install: $(addprefix install-exec-,$(PROGRAMS))

install-exec-%: install-dirs
	$(INSTALL) -m $(EXECMODE) $*  $(BINDIR)

install-dirs:
	$(INSTALL) -m $(DIRMODE) -d $(BINDIR)

check-%:
	$(MAKE) -C t -f $(@:check-%=%.tmk) TOPDIR=.. check

.PHONY: all check install install-exec-% install-dirs check-%
