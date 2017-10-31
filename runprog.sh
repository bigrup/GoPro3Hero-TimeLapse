#! /bin/bash
FILE=list.txt

#tail -n +2 "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
#
#
#
#      BIG PROBLEMS    ****************************  TODO
#
#
#
# Files are no longer being sorted. Had to use the following. 
#
#
#   sort -o list2.txt list.txt
#
# This took the output file from list.txt and sorted into list2.txt.
#
#   NEED TO REPLACE FILE FOR THIS PROGRAM TO RUN SUCCESSFULLY
#
#
# also used, 
#   
#     grep -v -e '#current' output02264.sh > output1.sh
# 
# To strip out all debug comments and see the order. 
#
#
#  and then  sort -o output2.sh output1.sh  but because i forgot to replace the file before.
#

total_files=`cat list.txt | wc -l`
#use wordcount to find out how many records have been generated.
# TODO Might need to cut the head off...

echo "Total number of files in list.txt is $total_files"

files_needed=$(($total_files / 30))
# Based on calculations of 1440 photos /day @ 24 fps video, 2 months of growth = 2880 pictures for 2 mins footage
# This requires 1 photos out of 30
# This number also drives the loop to cycle through the filenames and to construct the 'action file'

#check modulus to see if we need an extra photo from the end of the set or does the last photo land on modulus

if (("$total_files" % 30 != 0)); then
 	last_picture=1
 	echo "The number of photos needed is total/30+1 = $(($files_needed+1))"
 else
 	last_picture=0
 	echo "The number of photots needed is total/30 = $files_needed"
 fi



echo -n "Please enter the start Value (if not starting from 0, or enter 0): " 
 read var_name

printf -v start_val "%05d" $var_name
# If this isn't the first time the file is run it needs to follow on from previous runs...
# enter that number here
# TODO Find the number automatically


 echo "The number entered is $var_name"

#do we still need this as we cant use for/seq loop?
end_value=$(($var_name + $files_needed + $last_picture))

# This drives the end value in the seq command


echo "The final photo number should be $end_value"

 echo -n "ready to run? press return to continue... "
 read hello


 #check modulus to see if we need an extra photo from the end of the set or does the last photo land on modulus



current_filename=original_filename
current_set=0
current_picture=0

if [ ! -d "DCIM/output" ]; then
	mkdir DCIM/output
fi

 while IFS= read original_filename
 do
 	printf -v var_name_formatted "%05d" $var_name
 	if (( "$current_set" == "0" )) || (( ("$current_set" % 30 == "0") )); then
 		echo "cp $original_filename DCIM/output/rup$var_name_formatted.jpg" >> output$start_val.sh
 		echo "#current set = $current_set | current_picture = $current_picture" >> output$start_val.sh
 		echo "Copy written for $var_name_formatted"
 		current_set=$(($current_set+1))
 		var_name=$(($var_name+1))
 		current_picture=$(($current_picture+1))
 		current_filename=$original_filename
 	else 
 		echo "#current set = $current_set | current_picture = $current_picture NO COPY" >> output$start_val.sh
 		current_set=$(($current_set+1))
 		current_filename=$original_filename
 	fi

 done < list.txt

 if (( "$last_picture" == "1")); then
 	printf -v var_name_formatted "%05d" $var_name
 	echo "cp $current_filename DCIM/output/rup$var_name_formatted.jpg" >> output$start_val.sh
 	echo "#FINAL set is $current_set" >> output$start_val.sh
 fi

chmod 755 output$start_val.sh

echo "Script is complete"
echo "You need to run ....    chmod 755 output$start_val.sh   "
echo "Script to run is...   ./output$start_val.sh"

 #i=99
#$ printf -v j "%05d" $i
#$ echo $j
#00099


# for i in $(seq -f "%05g" $var_name $end_value)
 # the -f enables the formatting. 10000 should be 5 times more needed for 2 months growth
 #do 
 #echo "mv csomething to RUP$i.JPG"
#done

#for i in $(seq -f "%05g" 1059 3834); do echo $i; done

#for (( COUNTER=0; COUNTER<=10; COUNTER+=2 )); do
#    echo $COUNTER
#done