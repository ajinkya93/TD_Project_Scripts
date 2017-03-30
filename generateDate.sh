#!/bin/bash

#DATE=2014-07-10


while IFS='' read -r file || [[ -n "$file" ]]
do
	echo "File: $file"
	START_DATE=2014-07-10
	CURRENT_DATE=$(date +%Y-%m-%d) #2017-2-22
	MAX_NO_OF_CHANGES=0
	if [ ! -f $file ]
	then
		printf "$file\n" >> files_do_not_exist
	else
	
		#echo "$(date +%Y-%m-%d -d "2014-07-10 +3months")"
		#echo "$(date +%Y-%m-%d -d "$START_DATE + 3 months")"
		END_DATE=$(date +%Y-%m-%d -d "$START_DATE + 3 months")
		while [[ $END_DATE < $CURRENT_DATE ]]
		do
			COMMITS=$(git log --follow  --pretty=format:%H --after="$START_DATE" --before="$END_DATE" $file)
			#printf "$COMMITS\n"
			NO_OF_CHANGES=$(echo "$COMMITS" | wc -w)
			#printf "No. of commits: $NO_OF_CHANGES\n"
			if [[ $NO_OF_CHANGES -gt $MAX_NO_OF_CHANGES ]]
			then
				MAX_NO_OF_CHANGES=$NO_OF_CHANGES
				printf "New MAX VALUE: $MAX_NO_OF_CHANGES\n"
				MAX_CHANGE_INTERVAL_START=$START_DATE
				MAX_CHANGE_INTERVAL_END=$END_DATE
			fi
			START_DATE=$(date +%Y-%m-%d -d "$START_DATE + 1 months") #Increase the interval start date by one month
			END_DATE=$(date +%Y-%m-%d -d "$START_DATE + 3 months")
			#printf "crypto/x509/x509_vfy.c,$MAX_NO_OF_CHANGES\n" >> Results.csv
		
		done
		printf "$file,$MAX_NO_OF_CHANGES,$MAX_CHANGE_INTERVAL_START,$MAX_CHANGE_INTERVAL_END\n" >> Results.csv
	fi
	
#done < Files_with_Deleted_Comments
#done < restored_files_first_pass
#done < restored_files_second_pass
#done < restored_files_third_pass
#done < restored_files_fourth_pass
done < restored_files_fifth_pass
exit 0
