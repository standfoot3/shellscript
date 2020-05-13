
#!/usr/bin/bash

#環境変数のインポート
. ./variable.txt

#Git/GitHub用コマンド
ADD_ALL="git add --all"
REMOVE_ALL="git rm -a"
CHECK_STATUS="git status --short"
COMMIT="git commit -m "
ADD_TO_GITHUB="git push shellscript branch1.0"

#関数
function func_ope_loop(){
	if [ $# -eq 1 ]; then
		ls -ltr | tail -n +2
		read -p "●Which is a targeted item ? (if nothing : q) : " TI
		if [ ${TI} = q ]; then
			:
		else	
			if [ ! -e ${TI} ]; then
				echo ${TI}" doesn't exist in the current directory."
				func_ope_loop {OPE}
			else
				echo ${TI}" is "${OPE}"ed"
				func_ope_loop {OPE}
			fi
		fi
		echo ${CHECK_STATUS}
		${CHECK_STATUS}
	fi
}
#何をしたいか聞く
read -p "${ASK_OPERATION}" OPE
func_add_remove ${OPE}

#変数OPEの変換
if [ ${OPE} = a ]; then
	OPE=add
else
	OPE=remove
fi

#追加or削除スタート
read -p "Do you "${OPE}" all materials ? or select materials ? (a:all / s:select) : " AS
if [ ${AS} = a ]; then
	echo ${ADD_ALL}
	${ADD_ALL}
	read -p "${OK_DIALOG}" YN
	func_yes_no ${YN}
else
	func_ope_loop ${OPE} 
fi

#GitへのCommit
read -p "●Enter Comment for Commit : " CC
echo "**********Commit Start**********"
${COMMIT}${CC}
echo ${COMMIT}${CC}
func_return_code ${?} "Commit"

#Githubへadd/remove
if [ ${OPE} = "add" ]; then
	echo ${ADD_TO_GITHUB}
	${ADD_TO_GITHUB}
else
	ecoh ${REMOVE_FROM_GITHUB}
	${REMOVE_FROM_GITHUB}
fi 

#Success
exit 0
