#!/bin/bash
if [[ -n $COCCI_DIR ]] ; then
    . $COCCI_DIR/env.sh $COCCI_DIR > /dev/null
fi

file="$1"

opts="--debug" # --verbose-parsing"

spatch() {
    echo "#####" "$@"
    spatch.opt $opts --max-width=1000 --in-place --sp-file janitor/$1 "$file"
}
spatch for_increment_by.cocci
spatch for_increment.cocci
spatch increment_seq.cocci
spatch for_increment_fast.cocci
spatch for_increment.cocci
spatch for_decrement_fast.cocci
spatch for_decrement.cocci
spatch arr_loop.cocci