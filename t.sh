#!/bin/sh

# remote container で cd ~ すると 見えないが配下に/workspaces/syssof はいる

# 動作確認にはまず監視対象ファイルを用意
# 別ユーザーを用意 パスワードもちゃんとつける
# このファイルを実行 第一引数に対象ファイル 第二引数に対象ユーザー
# ユーザーを変更してviでファイルをいじってみる
# ちゃんとログがでているか確認
# 特定ファイルを監視 変更があった際に /script/log.txtにechoで追加する 時刻と実行ユーザー

# https://qiita.com/tamanobi/items/74b62e25506af394eae5

# eval $2 コマンドを実行しようとしている もとの名残

# TODO: ログファイルの編集権限

CURRENT=$(cd $(dirname $0);pwd)
echo "test" >> "$CURRENT/log.txt"