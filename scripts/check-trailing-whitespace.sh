#!/bin/bash

if [[ $(git --no-pager grep -r '[[:blank:]]$' . | wc -l) -eq 0 ]];
then
    echo "No files with trailing spaces found"
    exit 0
else
    echo "These files have trailing whitespaces. Please fix."
    git --no-pager grep -r '[[:blank:]]$' .
fi
