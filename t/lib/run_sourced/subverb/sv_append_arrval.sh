declare -A foo

sv_append_arrval foo bar 1 ", "
sv_append_arrval foo bar 2 ", "
sv_append_arrval foo bla 3 ", "

for i in bar bla; do
	echo "$i: ${foo[$i]}"
done
