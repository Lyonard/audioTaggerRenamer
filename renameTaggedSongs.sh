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
		_infos=$( mdls $i | egrep "(ItemComposer|ItemDisplayName|ItemFSName|kMDItemKind)" | cut -d "=" -f 2 | cut -d "\"" -f 2);
		_composer=$( echo "$_infos" | awk -v FS="\n" -v RS= -v OFS=@ '{print $1}');
		_displayName=$( echo "$_infos" | awk -v FS="\n" -v RS= -v OFS=@ '{print $2}');
		_fsName=$( echo "$_infos" | awk -v FS="\n" -v RS= -v OFS=@ '{print $3}');
		_itemKind=$( echo "$_infos" | awk -v FS="\n" -v RS= -v OFS=@ '{print $4}');
		
		echo $_displayName @@@ $_fsName @@@@ $_itemKind;

		if [[ "$_itemKind" != *"Audio"* ]]
			then
			echo $_fsName "seems not to be an audio file. Skip? (y/n)";
			read answer;
			while [[ "$answer" != "y" && "$answer" != "n" ]]; do
				echo $_fsName "seems not to be an audio file. Skip? (y/n)";
				read answer;
			done

			if [[ "$answer" == 'n' ]]; then
				echo "Exiting..";
				exit 2;
			else
				SKIPPED=$SKIPPED+1;
				continue;
			fi
		fi


		filename=$(basename "$_fsName")
		extension="${filename##*.}"
		echo $extension;
		#mv $3 ../renamed/$1-$2.$extension;

		#>> /tmp/songs
done
IFS=$SAVEIFS;


#for i in $(cat /tmp/songs.txt)
#	do A=`echo $i | cut -d "@" -f 1`; B=`echo $i | cut -d "@" -f 2 `;C=`echo $i | cut -d "@" -f 3`; mv $A $B-$C 
#done                               
