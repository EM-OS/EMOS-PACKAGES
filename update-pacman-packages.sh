#!/bin/bash


echo "updateing and syncing pacman packages...."


PACKAGES=$(pacman -Ssq)

echo "$PACKAGES" > all-packages.txt


echo "updated the current list of packages"
