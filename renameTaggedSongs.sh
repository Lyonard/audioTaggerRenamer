#!/bin/bash
function getUsage {
	echo -e "Usage:";
	echo -e "\t./renameTaggedSongs.sh [ -h | -v | -s ] songsFolderPath\n"
	echo -e "For more informations write \"man ./renameTaggedSongs\"\n"
}

__verbose=false;
__skipAuto=false;

if [ $# -eq 0 ]
then
       getUsage;
       exit 2;
fi
set -- $args

while [ $# -ne 0 ]; do
    case $1 in
        -h|--help)
            getUsage;
            shift
            ;;
        -v|--verbose)
            __verbose=true;
            shift
            ;;
        -s|--skipauto)
            __skipAuto=true;
            shift
            ;;

        --) #end of parameters, exit while loop
            shift; break
            ;;

        \?|*) #unrecognized option - show help
            getUsage
            exit 2
            ;;
    esac
done

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

		if [[ "$_itemKind" != *"Audio"* ]]
			then
			if $__skipAuto 
				then
				SKIPPED=$SKIPPED+1;
				continue;
			else
				echo -n $_fsName " seems not to be an audio file. Skip? (y/n) ";
				read answer;
				while [[ "$answer" != "y" && "$answer" != "n" ]]; do
					echo -n $_fsName " seems not to be an audio file. Skip? (y/n) ";
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
		fi

		if $__verbose 
			then 
			echo -e "Composer:\t $_composer"; 
			echo -e "Title:\t\t $_displayName";
			echo -e "filename:\t $_fsName";
			echo "";
		fi;

		filename=$(basename "$_fsName")
		extension="${filename##*.}"
		#echo $extension;

		echo $_fsName;
		cp $_fsName ../renamed/$_displayName-$_composer.$extension;
done
IFS=$SAVEIFS;
