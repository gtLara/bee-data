#!/bin/bash

input_file=${1-data/processed/metadata.csv}
input_dir=${2-data/processed/audio}
output_dir=${2-data/processed/spectrogram}

echo $input_dir

if [ ! -f "$input_file" ]; then
    echo Arquivo de metadados inexistente. Certifique-se que existe e contem os dados apropriados.
    echo Encerrando execucao
    exit
fi

if [ ! -d "$input_dir" ]; then
    echo Diretorio fonte inexistente. Certifique-se que existe e contem os dados apropriados.
    echo Encerrando execucao
    exit
fi

if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

sed '1d' $input_file | while ifs= read -r line
do

    file_name=$(echo $line | cut -d"," -f1)
    stem="${file_name%.*}"

    sox $input_dir/$file_name -n spectrogram -o $output_dir/$stem.png

done
