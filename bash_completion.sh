_subverb_complete() {
	local CMD=$1
	shift
	# echo $COMP_CWORD: "${COMP_WORDS[@]}"
	readarray -t COMPREPLY < <( ( echo ${COMP_CWORD}; for i in "${COMP_WORDS[@]}"; do echo "$i"; done ) | ${CMD} bash-completion "$@")
}
