#!/bin/bash
enscript -2rG -p - --line-numbers --color=1 -c $1 > out.ps && open out.ps