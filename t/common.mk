export OUTPUT
export DESCRIPTION
export SVBASEDIR=.

LN_SF?=ln -sf

check: $(COMMAND).cmp

banner:
	@echo ========================================
	@echo $(COMMAND) $(SUBVERB) $(ARGUMENTS)
	@echo "$${DESCRIPTION}"
	@echo ========================================

$(COMMAND): $(TOPDIR)/subverb
	$(LN_SF) $< $@

.$(COMMAND).res: banner $(COMMAND) $(COMMAND).tmk common.mk
	./$(COMMAND) $(SUBVERB) $(ARGUMENTS) | tee .$(COMMAND).res

.$(COMMAND).ref: $(COMMAND).tmk common.mk | banner
	echo "$$OUTPUT" > $@

$(COMMAND).cmp: .$(COMMAND).ref .$(COMMAND).res
	diff -u .$(COMMAND).ref .$(COMMAND).res | tail -n +3
	@cmp .$(COMMAND).ref .$(COMMAND).res || (echo "t/$(COMMAND).tmk:1: unexpected output"; false)

.PHONY: banner check $(COMMAND).cmp
