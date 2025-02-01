#!/bin/sh
# PORT が設定されていなければ 8080 をデフォルトとする
PORT=${PORT:-8080}
# Ollama サーバーがリッスンするアドレスを設定
export OLLAMA_HOST="0.0.0.0:$PORT"
echo "Starting Ollama server on port $PORT..."
# exec でプロセスを置き換え、サーバーを起動
exec ollama serve