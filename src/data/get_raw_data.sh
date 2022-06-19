#!/bin/bash

echo Certifique que zenodo_get está instalado no ambiente atual

output_dir=${1-data/raw}

if [ ! -d "$output_dir" ]; then
    mkdir -d "$output_dir"
fi

# Múltiplas iterações para garantir download

for i in {0..2}
do
    zenodo_get -t 45 -p 0.5 -R 10 -o "$output_dir" 1321278
done
