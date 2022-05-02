#!/bin/bash

echo Certifique que zenodo_get está instalado no ambiente atual

zenodo_get -t 45 -p 0.5 -o ${1-../../data/raw/} 1321278
