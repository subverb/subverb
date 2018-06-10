# SV_GROUP: init
SV_OPTION[foobar]=FOOBAR
SV_OPTION_HELP[FOOBAR]="help for subverb option FOOBAR"
SV_HANDLE_HELP="sourced"
if [ "$1" == "_help_source_" ]; then
	return 0
fi
echo "This text should not be printed"
