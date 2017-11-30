for i in PARAM{1,2,3,4}; do
	echo $i=$(sv_evaldir $i /default suffix)
done
