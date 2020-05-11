
#!/usr/bin/bash

#環境変数のインポート
. ./variable.txt

#Git/GitHub用コマンド
ADD_ALL="pwd"    #"git add --all"
REMOVE_ALL="pwd" #"git rm -a"
CHECK_STATUS="git status --short"

#関数
function func_ope_loop(){
	if [ $# -eq 1 ]; then
		func_command "ls -ltr"
		read -p "Which is a targeted item ? (if nothing:END) : " TI
		if [ ${TI} = "END" ]; then
			:
		else	
			ls -ltr ${TI}
			if [ $? -ne 0 ]; then
				echo ${TI}" doesn't exist in the current directory."
				func_ope_loop {OPE}
			else
				echo ${TI}" is "${OPE}"ed"
				func_ope_loop {OPE}
			fi
			func_command ${CHECK_STATUS}
		fi
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
	func_command_ok ${ADD_ALL}
	
else
	func_ope_loop ${OPE} 
fi
