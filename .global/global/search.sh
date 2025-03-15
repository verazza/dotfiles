#!/bin/bash

SEARCH_QUERY="$1"

# URL かどうかを判定する正規表現
if [[ "$SEARCH_QUERY" =~ ^https?:// ]]; then
    # URLの場合、エンコードせずにそのまま開く
    w3m -num -o document_charset=Shift_JIS "$SEARCH_QUERY"
else
    # ENCODED_QUERY=$(echo "$SEARCH_QUERY" | jq -sRr @uri)
    ENCODED_QUERY=$(echo -n "$SEARCH_QUERY" | python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.stdin.read().strip()))")

    # https://search.yahoo.co.jp/search?p=
    w3m -num -o document_charset=Shift_JIS "https://www.google.com/search?q=$ENCODED_QUERY"
fi
