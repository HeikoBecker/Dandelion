#!/bin/bash

#Exclude Holmake files as they need tabs for indenting additional targets
if [[ $(git --no-pager grep -rlP '\t:(exclude)Holmakefile'| wc -l) -eq 0 ]];
then
    echo "All files properly indented"
    exit 0
else
    echo "These files use tabs for indentation. Please fix."
    git --no-pager grep -rlP '\t' .
    exit 1
fi
