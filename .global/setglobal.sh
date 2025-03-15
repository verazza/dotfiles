#!/bin/bash

cd "$(dirname "$0")"

SOURCE_DIR="./global"

DEST_DIR="/usr/local/bin"

for file in "$SOURCE_DIR"/*.sh; do
    if [ -f "$file" ]; then
        filename=$(basename "$file" .sh)

        dest_file="$DEST_DIR/$filename"

        sudo cp "$file" "$dest_file"

        sudo chmod +x "$dest_file"
        echo "コピー完了: $file -> $dest_file"
    else
        echo "対象ファイルが見つかりません: $file"
    fi
done

echo "すべての.shファイルのコピーが完了しました。"
