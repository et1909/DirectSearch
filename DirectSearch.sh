#!/bin/bash

read -p "Request URL: " url
read -p "Request Wordlist: " wordlist
tmp_file="/tmp/temp_memfile.txt"
#read -p "Number of Thread" threading
count=1
while IFS= read -r line
do
	echo "Curling.... ($count)"
	full_url=$url$line
	request_code=$( curl -s -o /dev/null -I -w "%{http_code}" $full_url )
	echo $request_code >> $tmp_file
	echo $full_url >> $tmp_file
	count=$((count+1))
done < $wordlist

echo "Sorting...."
echo""
pat="^[0-9]*$"
output_file_name="/tmp/tempfile.txt"
list_of_200=('200 201 202 203 204 205 206 207 208 226');
list_of_400=('400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 421 422 423 424 425 426 428 429 431 451')


res2=$(grep -c "^[2]" "$tmp_file")
if [ $res2 -ge 1 ]
then
	valuefor2="True"
	echo "RESPONSE CODE : 200"
	echo "-------------------------------------------------------"
	for a in $list_of_200
	do
		res21=$(grep -c "$a" "$tmp_file")
		if [ $res21 -ge 1 ]
		then
			grep -A1 $a $tmp_file & grep -A1 $a $tmp_file >> $output_file_name &
		fi
	done
	echo "-------------------------------------------------------"
else
	echo "RESPONSE CODE : 200"
        echo "-------------------------------------------------------"
	echo ""
	echo "-------------------------------------------------------"
	
fi





res3=$(grep -c "^[3]" "$tmp_file") 
if [ $res3 -ge 1 ]
then
        valuefor3="True"
        echo "RESPONSE CODE : 300"
        echo "-------------------------------------------------------"
        for a in $list_of_300
        do
                res31= $(grep -c "$a" "$tmp_file")
                if [ $res31 -ge 1 ]
                then
                        grep -A1 $a $tmp_file & grep -A1 $a $tmp_file >> $output_file_name &
                fi
        done
        echo "-------------------------------------------------------"
else
        echo "RESPONSE CODE : 300"
        echo "-------------------------------------------------------"
        echo ""
        echo "-------------------------------------------------------"

fi




res4=$(grep -c "^[4]" $tmp_file)
if [ $res4 -ge 1 ]
then
	valuefor4="True"
	echo "RESPONSE CODE : 400"
	echo "-------------------------------------------------------"
	for a in $list_of_400
	do
		res41=$(grep -c "$a" "$tmp_file")
		if [ $res41 -ge 1 ]
		then
			grep -A1 $a $tmp_file & grep -A1 $a $tmp_file >> $output_file_name &
		fi
	done
	echo "-------------------------------------------------------"
else
	echo "RESPONSE CODE : 400"
	echo "-------------------------------------------------------"
	echo ""
	echo "-------------------------------------------------------"
fi


echo "------------Sorting Completed----------------"
rm $tmp_file
rm $output_file_name
