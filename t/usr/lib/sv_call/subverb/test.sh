bdir=usr/lib/sv_call/
for i in found shell error nf "nf found" nf "nf found error"; do
	echo -n "$i: "
	items=
	for f in $i; do
		items="$items $bdir/$f"
	done
	sv_call $items
	echo " (return $?/$RVAL)"
done
