export OUTPUT
export DESCRIPTION
export SVBASEDIR=.

LN_SF?=ln -sf

check: $(COMMAND).cmp

banner:
	@echo ========================================
	@echo $(COMMAND) $(GARGUMENTS) $(SUBVERB) $(ARGUMENTS)
	@echo "$${DESCRIPTION}"
	@echo ========================================

$(COMMAND): $(TOPDIR)/subverb
	test -f $@ || $(LN_SF) $< $@

.$(COMMAND).res: banner $(COMMAND) $(COMMAND).tmk common.mk

ifndef TEST_OWN_CMDDEF
.$(COMMAND).res:
	./$(COMMAND) $(GARGUMENTS) $(SUBVERB) $(ARGUMENTS) | tee .$(COMMAND).res
endif

.$(COMMAND).ref: $(COMMAND).tmk common.mk | banner
	echo "$$OUTPUT" > $@

$(COMMAND).cmp: .$(COMMAND).ref .$(COMMAND).res
	diff -u .$(COMMAND).ref .$(COMMAND).res | tail -n +3
	@cmp .$(COMMAND).ref .$(COMMAND).res || (echo "t/$(COMMAND).tmk:1: unexpected output"; false)

.PHONY: banner check $(COMMAND).cmp
