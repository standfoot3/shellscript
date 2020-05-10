
#!/usr/bin/bash

#変数定義
. ./variable.txt
if [ $# = 0 ]; then
	TARGET_FILE=index.html
elif [ $# = 1 ]; then
	TARGET_FILE=$1
else
	echo ${ARGUMENT_ERROR}
	exit 8
fi
echo ${ARGUMENT_OK}
EXIST="${TARGET_FILE} already exists"
NOT_EXIST="${TARGET_FILE} doesn't exist" 

#時刻取得
DATETIME="`date +"%y%m%d-%H%M%S"`"

#新規作成ファイル名
CREATE_FILE="index_${DATETIME}.html"

#変数定義チェック結果表示
echo "#####Variable Check START#####"
echo "TARGET_FILE=${TARGET_FILE}"
echo "DATETIME=${DATETIME}"
echo "CREATE_FILE=${CREATE_FILE}"
echo "######Variable Check END######"
echo

#対象ファイルの存在チェック
if [ -e ${TARGET_FILE} ]; then
	echo ${EXIST} 
	read -p "${RENAME_DIALOG}" YN
	func_yes_no ${YN}
	mv ${TARGET_FILE} ${CREATE_FILE}
else
	echo ${NOT_EXIST}
	read -p "${CREATE_DIALOG}" YN
	func_yes_no ${YN}
	CREATE_FILE=${TARGET_FILE}
	touch ${CREATE_FILE}
fi
echo `ls -ltr ${CREATE_FILE}` 
exit 0


