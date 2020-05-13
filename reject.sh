
#!/usr/bin/bash

INPUT_FILE="msg_id.txt"
OUTPUT_FILE="result.txt"

if [ ! -e ${OUTPUT_FILE} ]; then
	:
else 
	echo ${OUTPUT_FILE}"を削除してから実行して下さい。"
	exit 8
fi

while read line
do
	echo "'"${line}"'", >> ${OUTPUT_FILE}
done < ./${INPUT_FILE}
cat result.txt
