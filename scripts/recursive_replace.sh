#!/bin/bash
find ./ -name "$1" -exec sed -i '' -e 's/$2/$3/g' {} \;
