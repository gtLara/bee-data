#!/bin/bash

echo Certifique que zenodo_get está instalado no ambiente atual

# Múltiplas iterações para garantir download
# TODO: explicar

for i in {0..2}
do
    zenodo_get -t 45 -p 0.5 -R 10 -o ${1-../../data/raw/} 1321278
done
