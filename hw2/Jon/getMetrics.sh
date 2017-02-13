#!/bin/bash

cd Results/csv
rm *.txt 2>/dev/null;
rm *.dat 2>/dev/null;
rm *.dec 2>/dev/null;
rm *.enc 2>/dev/null;

folder1="data_crc";
folder2="data_dijkstra";
folder3="data_fft_inv";
folder4="data_fft";
folder5="data_qsort";
folder6="data_rawcaudio";
folder7="data_rijndael";
folder8="data_search";
folder9="data_sha";

mkdir -p $folder1;
mv crc* $folder1 2>/dev/null;

mkdir -p $folder2;
mv dijkstra* $folder2 2>/dev/null;

mkdir -p $folder3;
mv fft_inv* $folder3 2>/dev/null;

mkdir -p $folder4;
mv fft* $folder4 2>/dev/null;

mkdir -p $folder5;
mv qsort* $folder5 2>/dev/null;

mkdir -p $folder6;
mv rawcaudio* $folder6 2>/dev/null;

mkdir -p $folder7;
mv rijndael* $folder7 2>/dev/null;

mkdir -p $folder8;
mv search* $folder8 2>/dev/null;

mkdir -p $folder8;
mv search* $folder8 2>/dev/null;

mkdir -p $folder9;
mv sha* $folder9 2>/dev/null;



cd ../..
pwd
perl generateOutput.pl $folder1 > $folder1."_metrics.txt";
perl generateOutput.pl $folder2 > $folder2."_metrics.txt";
perl generateOutput.pl $folder3 > $folder3."_metrics.txt";
perl generateOutput.pl $folder4 > $folder4."_metrics.txt";
perl generateOutput.pl $folder5 > $folder5."_metrics.txt";
perl generateOutput.pl $folder6 > $folder6."_metrics.txt";
perl generateOutput.pl $folder7 > $folder7."_metrics.txt";
perl generateOutput.pl $folder8 > $folder8."_metrics.txt";
perl generateOutput.pl $folder9 > $folder9."_metrics.txt";



