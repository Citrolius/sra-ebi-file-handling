#!/bin/bash

set -eu
#echo "Processing"

: <<"comments"
source of information https://www.ncbi.nlm.nih.gov/books/NBK158899/#SRA_download.what_key_file_should_be_use

download location for a data file is:
wget ftp://ftp-trace.ncbi.nih.gov
followed by
/sra/sra-instant/reads/ByRun/sra/{SRR|ERR|DRR}/<first 6 characters of accession>/<accession>/<accession>.sra

EXAMPLE ERR719171

wget ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/ERR/ERR719/ERR719171/ERR719171.sra

In python you use slice to extract certain parts of string
In bash you would use cut -c which counts from one and include the last character.
Then you use parenthesis to assign variable not curly braces.

comments

#direct standard output to file
ls -a | tee log_download.txt
ftplink="ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/ERR/"

while read LINE
do
	echo $LINE #read accessions from txt
	first_six=$(echo $LINE| cut -c1-6) #obtain the first 6 characters of accession
	link=$"$ftplink$first_six/$LINE/$LINE.sra" #constructing the hyperlink into $link.
	
	wget $link
	
	if [ -f $LINE".sra" ]
	then
	    echo $LINE 'has been downloaded.'
	else
	    echo $LINE 'has failed to download.'
	fi
	
	echo "extracting foward and reverse read from sra into separate fastq files"
		
done <$1

echo "The script has completed, please check log"
echo '+%d/%m/%Y %H:%M:%S'







