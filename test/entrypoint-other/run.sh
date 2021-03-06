#!/usr/bin/env bash

clean() {
	rm -f $file1 $file2
}
trap clean EXIT

file1=`mktemp`
file2=`mktemp`
docker run --rm $1 echo OK > $file1 || exit 1
echo OK > $file2
diff $file1 $file2 || exit 1

../build/docker-entrypoint.sh false && exit 1
../build/docker-entrypoint.sh true || exit 1
