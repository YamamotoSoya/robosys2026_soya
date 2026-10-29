#!/bin/bash

ng () {
		echo ${1}行目のテスト失敗 # $1はngの一番目の引数
		res=1
}

res=0
a=山本
[ "$a" = 山木 ] || ng "$LINENO"
[ "$a" = 山本 ] || ng "$LINENO"

exit $res
