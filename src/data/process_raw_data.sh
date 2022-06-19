#!/bin/bash

function parse_file {

    lab_file=$clean_datadir/$1

    read -r audio_name < $lab_file # Reads first line of file which contains audio file name
    audio_file=$clean_datadir/$audio_name.wav

    # Begins .lab file interpreation loop

    # line structure:  start_time end_time label
    # example: 0 8.0 bee

    local_counter=0
    sed '1d; $d' $lab_file | while ifs= read -r line # Reads all lines except first and last
    do

        start=$(echo $line | cut -d" " -f1)
        end=$(echo $line | cut -d" " -f2)
        label=$(echo $line | cut -d" " -f3)

        duration=$(bc <<< "$end-$start")

        output_file=$counter-$local_counter.wav

        sox $audio_file $output_dir/audio/$output_file trim $start $duration

        echo "${output_file}, ${duration}, ${label}" >> $output_dir/metadata.csv

        local_counter=$((local_counter+1))

    done

}

input_dir=${1-data/raw}
output_dir=${2-data/processed}
counter=0

if [ ! -d "$input_dir" ]; then
    echo Diretorio fonte inexistente. Certifique-se que existe e contem os dados apropriados.
    echo Encerrando execucao
    exit
fi

if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir/audio"
fi

echo "Audio File, Duration, Label" > $output_dir/metadata.csv

# Removing spaces from files temporarily

clean_datadir="/tmp/parser"
mkdir -p $clean_datadir

for f in $input_dir/*
do
    filename=$(basename -- "$f") # Getting base filename
    clean_filename=${filename//[\(\) ]/} # Cleaning name
    extension="${filename##*.}" # Getting file extension

    cp "$f" $clean_datadir/$clean_filename

    if [[ "$extension" == "mp3" ]]
    then
        # Dealing with format inconsistency
        # if mp3 file convert to wav

        stem="${clean_filename%.*}"
        ffmpeg -hide_banner -loglevel error -i  "$f" $clean_datadir/$stem.wav
    fi

    if [[ "$extension" == "lab" ]]
    then
        # Cleaning file:
        #   - Removing DOS newline character
        #   - Cleaning audio filename as in 9 lines above

        sed -i "s/[\r\(\) ]//g" $clean_datadir/$clean_filename # Cleaning file:
    fi

done

for f in $clean_datadir/*.lab
do
    parse_file $(basename -- "$f") # Parsing file
    counter=$((counter+1))
done

rm -r $clean_datadir
