dump_vars() {
	for i in "$@" ; do
		declare -n VAL=$i
		echo $i=$VAL
	done
	echo SV_UNPARSED="${SV_UNPARSED[@]}"
}

do_parse_options() {
	echo sv_parse_options "$@"
	sv_parse_options "$@"
}

test_long_options() {
	do_parse_options --foo --bar "a value" --foobar --reset "bla"
	echo unparsed: $?
	dump_vars FOO NOFOO BLABLUPP SET RESET FOOBAR
}

echo Parsing specified long options
declare -A SV_OPTION=(
		[foo]=:FOO
		[flag]=:NOFOO
		[bar]=BLABLUPP
		[set]=UNSET
		[reset]=RESET
		)
test_long_options
echo

echo Parsing auto-options
SV_AUTO_OPTIONS=1
test_long_options
echo

echo Parsing short options
declare -A SV_SHORT_OPTION=(
		[a]=:BAR
		[b]=BLUPP
		[c]=:UNBAR
		)
do_parse_options -b  something -a averb
dump_vars BAR BLUPP UNBAR
