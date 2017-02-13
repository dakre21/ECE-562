#!/bin/bash


ExecDirectory=$(pwd);
DataDirectory="Results"

rm $ExecDirectory"/"$DataDirectory"/"*.txt 2>/dev/null;
rm $ExecDirectory"/"$DataDirectory"/"*.dat 2>/dev/null;
rm $ExecDirectory"/"$DataDirectory"/"*.dec 2>/dev/null;
rm $ExecDirectory"/"$DataDirectory"/"*.enc 2>/dev/null;

# Create the output folders where the data will be generated
# then move the benchmark files into their corresponding directories
folder1="data_crc";
folder2="data_dijkstra";
folder3="data_fft_inv";
folder4="data_fft";
folder5="data_qsort";
folder6="data_rawcaudio";
folder7="data_rijndael";
folder8="data_search";
folder9="data_sha";

mkdir -p $ExecDirectory"/"$DataDirectory"/"$folder1;
mv $ExecDirectory"/"$DataDirectory"/"crc* $ExecDirectory"/"$DataDirectory"/"$folder1 2>/dev/null;

mkdir -p $ExecDirectory"/"$DataDirectory"/"$folder2;
mv $ExecDirectory"/"$DataDirectory"/"dijkstra* $ExecDirectory"/"$DataDirectory"/"$folder2 2>/dev/null;

mkdir -p $ExecDirectory"/"$DataDirectory"/"$folder3;
mv $ExecDirectory"/"$DataDirectory"/"fftinv* $ExecDirectory"/"$DataDirectory"/"$folder3 2>/dev/null;

mkdir -p $ExecDirectory"/"$DataDirectory"/"$folder4;
mv $ExecDirectory"/"$DataDirectory"/"fft* $ExecDirectory"/"$DataDirectory"/"$folder4 2>/dev/null;

mkdir -p $ExecDirectory"/"$DataDirectory"/"$folder5;
mv $ExecDirectory"/"$DataDirectory"/"qsort* $ExecDirectory"/"$DataDirectory"/"$folder5 2>/dev/null;

mkdir -p $ExecDirectory"/"$DataDirectory"/"$folder6;
mv $ExecDirectory"/"$DataDirectory"/"rawcaudio* $ExecDirectory"/"$DataDirectory"/"$folder6 2>/dev/null;

mkdir -p $ExecDirectory"/"$DataDirectory"/"$folder7;
mv $ExecDirectory"/"$DataDirectory"/"rijndael* $ExecDirectory"/"$DataDirectory"/"$folder7 2>/dev/null;

mkdir -p $ExecDirectory"/"$DataDirectory"/"$folder8;
mv $ExecDirectory"/"$DataDirectory"/"search* $ExecDirectory"/"$DataDirectory"/"$folder8 2>/dev/null;

mkdir -p $ExecDirectory"/"$DataDirectory"/"$folder8;
mv $ExecDirectory"/"$DataDirectory"/"search* $ExecDirectory"/"$DataDirectory"/"$folder8 2>/dev/null;

mkdir -p $ExecDirectory"/"$DataDirectory"/"$folder9;
mv $ExecDirectory"/"$DataDirectory"/"sha* $ExecDirectory"/"$DataDirectory"/"$folder9 2>/dev/null;


perl $ExecDirectory"/"generateOutput.pl $ExecDirectory"/"$DataDirectory"/"$folder1 > $folder1"_metrics.txt";
perl $ExecDirectory"/"generateOutput.pl $ExecDirectory"/"$DataDirectory"/"$folder2 > $folder2"_metrics.txt";
perl $ExecDirectory"/"generateOutput.pl $ExecDirectory"/"$DataDirectory"/"$folder3 > $folder3"_metrics.txt";
perl $ExecDirectory"/"generateOutput.pl $ExecDirectory"/"$DataDirectory"/"$folder4 > $folder4"_metrics.txt";
perl $ExecDirectory"/"generateOutput.pl $ExecDirectory"/"$DataDirectory"/"$folder5 > $folder5"_metrics.txt";
perl $ExecDirectory"/"generateOutput.pl $ExecDirectory"/"$DataDirectory"/"$folder6 > $folder6"_metrics.txt";
perl $ExecDirectory"/"generateOutput.pl $ExecDirectory"/"$DataDirectory"/"$folder7 > $folder7"_metrics.txt";
perl $ExecDirectory"/"generateOutput.pl $ExecDirectory"/"$DataDirectory"/"$folder8 > $folder8"_metrics.txt";
perl $ExecDirectory"/"generateOutput.pl $ExecDirectory"/"$DataDirectory"/"$folder9 > $folder9"_metrics.txt";



