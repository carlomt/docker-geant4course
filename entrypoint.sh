#!/bin/bash

export HISTCONTROL=ignoredups

alias cd..='cd ..'
alias ls='ls -GF'
alias ll='ls -ltrh'

# Geant4
source  /opt/geant4/bin/geant4.sh

echo " "
echo "Geant4 docker for courses"
echo "#############################################################################################"
echo " "

# Execute the command passed to the Docker container
exec "$@"
