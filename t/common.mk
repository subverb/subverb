export OUTPUT
export DESCRIPTION
export SVBASEDIR=.
ifdef INPUT
export INPUT
endif

V?=@
LN_SF?=ln -sf

check: $(COMMAND).cmp

banner:
	@echo ========================================
	@echo $(COMMAND) $(GARGUMENTS) $(SUBVERB) $(ARGUMENTS)
	@echo "$${DESCRIPTION}"
	@echo ========================================

$(COMMAND): $(TOPDIR)/subverb
	$(V)test -f $@ || $(LN_SF) $< $@

.$(COMMAND).res: banner $(COMMAND) $(COMMAND).tmk common.mk

ifndef TEST_OWN_CMDDEF
.$(COMMAND).res:
	@echo ./$(COMMAND) $(GARGUMENTS) $(SUBVERB) $(ARGUMENTS)
ifdef INPUT
	$(V)echo "$$INPUT" > .$(COMMAND).input
	$(V)./$(COMMAND) $(GARGUMENTS) $(SUBVERB) $(ARGUMENTS) < .$(COMMAND).input | tee .$(COMMAND).res
else
	$(V)./$(COMMAND) $(GARGUMENTS) $(SUBVERB) $(ARGUMENTS) | tee .$(COMMAND).res
endif
endif

.$(COMMAND).ref: $(COMMAND).tmk common.mk | banner
	$(V)echo "$$OUTPUT" > $@

$(COMMAND).cmp: .$(COMMAND).ref .$(COMMAND).res
	$(V)diff -u .$(COMMAND).ref .$(COMMAND).res | tail -n +3
	$(V)cmp .$(COMMAND).ref .$(COMMAND).res || (echo "t/$(COMMAND).tmk:1: unexpected output"; false)

.PHONY: banner check $(COMMAND).cmp
