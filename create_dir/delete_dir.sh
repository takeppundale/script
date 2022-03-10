#!/bin/bash
#
# フォルダ削除スクリプト
#  - 入力ファイル中の行を読出し、ファイル、フォルダを削除する。
#

INPUT_FILE="$1"

function main() {
    echo "delete directory start."

    while read line
    do
        rm -fr ${line} || fatal_error
        echo "  ${line}"
    done < ${INPUT_FILE}

    echo "done."
}

# ヘルプ
function usage() {
    cat << EOF
Usage: $(basename "$0") [-h]
Please input file name.

ex)
./delete_dir.sh hoge.txt

-h display this message
EOF
    exit 2
}

# パラメータ解析
function parse_param() {
    while getopts ":h" option
    do
        case $option in
            h)  usage
                ;;
            \?) usage
                ;;
        esac
    done
}

# ログを出力
function output_log() {
    local datetime
    datetime=$(date "+%Y/%m/%d %H:%M:%S.%3N")
    echo "[${datetime}]" "$1"
}

# 致命的エラー発生時の処理
function fatal_error() {
    output_log "fatal error."
    exit 1
}

# パラメータチェック
if [ $# != 1 ]; then
    echo "Parameter error.: $*"
    echo "Please input 1 file name."
    exit 1
fi

# ファイル存在チェック
if [ ! -e "$1" ]; then
    echo "No such a file. (${1})"
    exit 1
fi

parse_param "$@"
main

exit 0
