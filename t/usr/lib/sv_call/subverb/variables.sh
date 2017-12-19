for i in data pkgdata pkglib subverb sysconf; do
	echo $i: $(sv_default_dir $i)
done
