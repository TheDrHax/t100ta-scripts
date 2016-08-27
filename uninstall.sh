#!/bin/bash

for i in *; do
    [ -d "$i" ] && [ -e "$i/uninstall.sh" ] && ./$i/uninstall.sh
done

