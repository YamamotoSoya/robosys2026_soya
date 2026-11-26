#!/bin/bash
# SPDX-FileCopyrightText: 2026 Yamamoto Soya arukahole137@gmail.com
# SPDX-License-Identifier: BSD-3-Clause

ng () {                             
        echo ${1}行目のテスト失敗
        res=1
}

res=0

# y=2x+1上の5点
out=$(cat testdata/line.csv | ./approx)
[ "${out}" = "2.0000 1.0000" ] || ng "$LINENO"

# y=0.5x+1.2に近い5点
out=$(cat testdata/sample.csv | ./approx)
[ "${out}" = "0.5000 1.2000" ] || ng "$LINENO"

# y=-3x+4上の4点（負の値を含む）
out=$(cat testdata/negative.csv | ./approx)
[ "${out}" = "-3.0000 4.0000" ] || ng "$LINENO"

# y=1.93x+0.175に近い5点（小数・ばらつきあり）
out=$(cat testdata/decimal.csv | ./approx)
[ "${out}" = "1.9300 0.1750" ] || ng "$LINENO"

# 数値でない行がある
out=$(cat testdata/error_text.csv | ./approx)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

# 1行の値が3つ
out=$(cat testdata/error_three_cols.csv | ./approx)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

# 点が1つだけ
out=$(cat testdata/error_one_point.csv | ./approx)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

# xがすべて同じ
out=$(cat testdata/error_same_x.csv | ./approx)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

# 空の入力
out=$(cat testdata/error_empty.csv | ./approx)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK         
exit $res                          
