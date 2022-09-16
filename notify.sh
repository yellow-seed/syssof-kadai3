#!/bin/sh

CURRENTDIR=$(cd $(dirname $0);pwd)

if [ $# -ne 1 ]; then
  echo "usage: bash notify.sh file_name"
  exit 1
fi

if [ ! -e "$1" ]; then # $1(ファイル)が見つからない
  echo "file not found in directory $CURRENTDIR."
  exit 1
fi

# 特定のユーザーを指定してその変更のみを監視できるオプションをつけたかったが精度の高いものを時間内に作れなかったので断念した

INTERVAL=300 # 監視間隔(秒) 用途に応じて調整する
TARGETDIR=$CURRENTDIR/logs
FILENAME=${1%.*}

last=echo`openssl sha256 -r $1`
lastinfo="cat $1"
cp $1 tmp # この時点の$1をコピーしたファイルを用意し比較に利用する

while true;
do
  sleep $INTERVAL
  current=echo`openssl sha256 -r $1`
  currentinfo="cat $1"

  if [ "$last" != "$current" ]; then
    nowdate=`date '+%Y/%m/%d'`
    nowdatefilename=`date '+%Y-%m-%d'`
    nowtime=`date '+%H:%M:%S'`
    size=`ls -l $1 | cut -d' ' -f5`

    if [ ! -d $TARGETDIR ]; then
      mkdir $TARGETDIR
    fi

    echo "$nowdate $nowtime: [FILE] $1 [BYTE] $size" >> "$TARGETDIR/notify_${nowdatefilename}.log";
    diff -u <(cat tmp) <($currentinfo) >> "$TARGETDIR/diff_${FILENAME}.log";
    last=$current
    cp $1 tmp # 変更後のファイルで比較用ファイルを上書きコピーする
  fi
done