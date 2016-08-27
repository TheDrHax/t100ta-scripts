#!/bin/bash

for i in *; do
    [ -d "$i" ] && [ -e "$i/install.sh" ] && ./$i/install.sh
done
