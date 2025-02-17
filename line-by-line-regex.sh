#Two files are read, each of them have corresponding lines because one file has
#the chinese lines the other ha the translated lines. These were extracted from
#the robot-unicode file. In order to place the translated lines back into the
#robot-unicode file, a search and replce must be executed. The reason for
#filtering out the english lines before translation is because the file has 2
#million lines while there are only 1200 lines (roughly) of chinese text. Google
#translate does not like being spammed .STEP lines
#
#The line files are converted into arrays which are them accessed by a for loop
#which moves up the index numbers. Each array is fed into their respective
#location within the sed command. It levarages the fact that each .STEP line has
#a unique identifying number (for the most part). The lines are also in order,
#which means that since /g is not used, it only does the 1st instance, changes
#it and moves on.
declare -a TRANSLATED_LINES
while IFS="" read -r p || [ -n "$p" ]
do
  #printf '%s\n' "$p"
  TRANSLATED_LINES+=("$p")
done < ./chinese-lines-english.txt

declare -a CHINESE_LINES 
while IFS="" read -r p || [ -n "$p" ]
do
  #printf '%s\n' "$p"
  CHINESE_LINES+=("$p")

done < ./chinese-lines.txt

linecount=$((${#TRANSLATED_LINES[@]}))

linecount=$((${linecount} - 1)) 
printf ${linecount}

i=0
out="./translated.STEP"


english=${TRANSLATED_LINES[$i]}
chinese=${CHINESE_LINES[$i]}
while read p; do

  echo "Current line: $p"
  echo "Attemting to match: $chinese"
  if [[ "$p"=="$chinese" ]]; then
	  echo "$english" >> ${out}
	  ((++i))
	  echo "match"
		english=${TRANSLATED_LINES[$i]}
		chinese=${CHINESE_LINES[$i]}
  else
	  echo "${p}" >> ${out}
	  echo "no match"
fi

echo "Index: $i"
done <./robot-unicode.STEP

#for i in $(seq 0 ${linecount});
#do
#	english=${TRANSLATED_LINES[$i]}
#	chinese=${CHINESE_LINES[$i]}
#	#prog="sed -i s/${chinese}/${english}/ ./robot-unicode.STEP"
#	prog=tr
#	echo ${prog}
#	${prog}
#	
#	echo $i
#	echo $english
#
#done


