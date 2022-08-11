#!/bin/bash

ORG=$1
REPO=$2

rm -rf code
git clone "https://github.com/$1/$2.git" code > /dev/null 2>&1
CONTRIBUTORS=$(curl -s "https://api.github.com/repos/$1/$2/contributors" | jq '. | length')

echo "PROJECT: $2 by $1"
echo -e "$CONTRIBUTORS contributors\n"

N_FILES=0
N_BAD_FORMAT=0
for i in `find ./code -name "*.cairo" -type f | grep -v 'code/lib/'`; do
    ((N_FILES++))
    cairo-format -c $i > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        ((N_BAD_FORMAT++))
    fi
done

echo -e "$N_FILES cairo files - $N_BAD_FORMAT misformatted\n"

AMARNA_TOTAL=$(amarna code/ -s | wc -l)
echo "Amarna Summary - $AMARNA_TOTAL infractions"

amarna code/ -s | awk '{print $1}' | sort | uniq -c | sort -nr
amarna code/ -o out.sarif

PROTO="code/protostar.toml"
PWD=$(pwd)
if [ -f "$PROTO" ]; then
    N_TESTS=$(find code/tests/ -name "test*.cairo" -type f | wc -l)
    echo -e "\n$2 uses protostar - $N_TESTS test files\n"
    if [ $N_TESTS -eq 0 ]; then
        echo -e "NO TESTS\n"
    else
        cd code
        protostar install > /dev/null 2>&1
        protostar test --no-progress-bar ./tests > ../test-out.txt 2>&1
        if [ $? -ne 0 ]; then
            echo -e "TESTS FAILED"
        else
            echo -e "TESTS PASSED"
        fi
        cd $PWD
    fi 
fi
