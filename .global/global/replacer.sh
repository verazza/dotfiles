#!/bin/bash

read -p "検索対象のディレクトリを入力してください（デフォルト: .）: " search_dir
search_dir=${search_dir:-.}

read -p "除外するディレクトリを入力してください（デフォルト: */node_modules）: " exclude_dir
exclude_dir=${exclude_dir:-*/node_modules}

read -p "検索する文字列を入力してください: " search_string

if [ -z "$search_string" ]; then
  echo "エラー: 検索する文字列を入力してください。" >&2
  exit 1
fi

read -p "置換する文字列を入力してください（空文字も許容）: " replace_string

find "$search_dir" -type f ! -path "$exclude_dir/*" -exec grep -l "$search_string" {} \; | while read -r file; do
    sed -i "s|$search_string|$replace_string|g" "$file"
    echo "置換完了: $file"
done
