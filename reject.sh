
#!/usr/bin/bash

#変数定義
. ./variable.txt
INPUT_FILE="msg_id.txt"
OUTPUT_FILE="output.txt"
SQL_FILE="execute.sql"

#inputfileの存在チェック
if [ ! -e ${OUTPUT_FILE} ]; then
	:
else 
	read -p ${OUTPUT_FILE}"を削除して良いですか？ : " YN
	func_yes_no ${YN}
	rm ${OUTPUT_FILE}
fi
echo

#inputfileの形式を整える
#ファイル内のスペースや空行を削除
echo "**********対象MSG_IDの整形開始**********"
sed -i '' '/^$/d' ${INPUT_FILE}    #空行削除
sed -i '' 's/ //g' ${INPUT_FILE}   #空白削除

#inputfileの中身を、'',で区切ってoutputfileに出力する
while read line
do
	echo "'"${line}"'", >> ${OUTPUT_FILE}
done < ./${INPUT_FILE}

#最後のカンマを削除
sed -i '' "$ s/,//" ${OUTPUT_FILE}
cat ${OUTPUT_FILE}
echo "**********対象MSG_IDの整形終了**********"
read -p "対象明細/形式はこれで間違いないですか？ : " YN
func_yes_no ${YN}
echo

#SQLファイルの存在チェック
if [ ! -e ${SQL_FILE} ]; then
	:
else
	read -p ${SQL_FILE}"を削除して良いですか？ : " YN
	func_yes_no ${YN}
	rm ${SQL_FILE}
fi
echo

#SQLファイルの作成
echo "**********SQLファイルの作成開始**********"
echo "SELECT *" >> ${SQL_FILE}
echo "FROM ATRDSADM.TBL_MSG" >> ${SQL_FILE}
echo "WHERE MSG_ID IN (" >> ${SQL_FILE}
while read msg_id >> ${SQL_FILE}
do
	echo ${msg_id} >> ${SQL_FILE}
done < ./${OUTPUT_FILE}
echo ")" >> ${SQL_FILE}
cat ${SQL_FILE}
echo "**********SQLファイルの作成終了**********"
read -p "SQLファイルは問題ないですか？ : " YN
func_yes_no ${YN}
echo

