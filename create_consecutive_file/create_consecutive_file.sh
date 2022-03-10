#!/bin/bash
#
# テスト用フォルダ作成スクリプト
#  - ベース名、拡張子を指定し、連番で空ファイルを生成する
#

BASE_NAME="$1"
EXTENSION="$2"
FILE_CNT="$3"

function main() {
    echo "create test file start."

    while [ $((idx+=1)) -le ${FILE_CNT} ]; do
        echo ${BASE_NAME}_${idx}.${EXTENSION}
        touch ${BASE_NAME}_${idx}.${EXTENSION} || fatal_error
    done

    echo "done"
}

# ヘルプ
function usage() {
    cat << EOF
Usage: $(basename "$0") [-h]
Please input file name.

ex)
./create_test_file.sh hogehoge txt 256

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

# ディレクトリ一覧表示
function view_list() {
    ls -l
}

# パラメータチェック
if [ ${#} != 3 ]; then
    echo "Parameter error.: $*"
    echo "Please input basename, extension, file count."
    exit 1
fi

parse_param "$@"
main

exit 0
