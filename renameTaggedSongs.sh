#!/bin/bash

DIR=$1;
if ! [ -d "$DIR" ]
then 
	echo "First argument must be a valid directory path.";
	echo "Exiting..";
	exit 1;
fi

cd $DIR;

SAVEIFS=$IFS;
IFS=$(echo -en "\n\b");
SKIPPED=0;

numOfFiles=$(ls -l | grep -v ^d | wc -l);

if [[ $numOfFiles -eq 0 ]]
	then 
	echo "No files found. Exiting...";
	exit 2;
fi

mkdir ../renamed;

for i in $(ls)
	do
		_composer=$( mdls $i | grep ItemComposer | cut -d "=" -f 2 | cut -d "\"" -f 2 );
		_displayName=$( mdls $i | grep ItemDisplayName | cut -d "=" -f 2 | cut -d "\"" -f 2 );
		_fsName=$( mdls $i | grep ItemFSName | cut -d "=" -f 2 | cut -d "\"" -f 2 );
		_itemKind=$( mdls $i | grep kMDItemKind | cut -d "=" -f 2 | cut -d "\"" -f 2 );
		
		echo $_composer;
		echo $_displayName;
		echo $_fsName;
		#echo $_itemKind;
		echo "";
		if [[ "$_itemKind" != *"Audio"* ]]
			then
			echo -n $_fsName "seems not to be an audio file. Skip? (y/n) ";
			read answer;
			while [[ "$answer" != "y" && "$answer" != "n" ]]; do
				echo -n $_fsName "seems not to be an audio file. Skip? (y/n) ";
				read answer;
			done

			if [[ "$answer" == 'n' ]]; then
				echo "Exiting..";
				exit 3;
			else
				SKIPPED=$SKIPPED+1;
				continue;
			fi
		fi


		filename=$(basename "$_fsName")
		extension="${filename##*.}"
		#echo $extension;
		cp $_fsName ../renamed/$_displayName-$_composer.$extension;
done
IFS=$SAVEIFS;