# ビルド用ステージ
FROM --platform=linux/amd64 ubuntu:20.04 AS builder

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    lsb-release \
 && rm -rf /var/lib/apt/lists/*

# Ollamaのインストール
RUN curl -fsSL https://ollama.com/install.sh | sh
RUN ollama --version

# サーバー起動とモデルダウンロード用スクリプト
# ※ビルド時は一時的にポート11434でサーバーを起動してモデルをダウンロードします。
RUN set -ex; \
    # サーバーをバックグラウンドで起動
    ollama serve & \
    SERVER_PID=$!; \
    echo "Waiting for ollama serve to be ready..."; \
    for i in $(seq 1 30); do \
        if curl -s http://localhost:11434 > /dev/null; then \
            echo "Server is up"; \
            break; \
        fi; \
        sleep 1; \
    done; \
    echo "Downloading model..."; \
    ollama run hf.co/elyza/Llama-3-ELYZA-JP-8B-GGUF; \
    echo "Stopping server..."; \
    kill $SERVER_PID; \
    wait $SERVER_PID || true

# 最終イメージ作成ステージ
FROM --platform=linux/amd64 ubuntu:20.04

# ランタイムに必要なパッケージをインストール
RUN apt-get update && apt-get install -y ca-certificates && apt-get clean && rm -rf /var/lib/apt/lists/*

# builder ステージから Ollama のバイナリとキャッシュ（モデルデータ）をコピー
COPY --from=builder /usr/local/bin/ollama /usr/local/bin/ollama
COPY --from=builder /root/.ollama /root/.ollama

# entrypoint.sh をコンテナにコピーし、実行権限を付与
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 環境変数 PORT をデフォルト 8080 に設定（Cloud Run 等で上書き可能）
ENV PORT=8080

# コンテナ内でリッスンするポートを EXPOSE（PORT は展開されないため数値で指定）
EXPOSE 8080

# コンテナ起動時は entrypoint.sh を実行
CMD ["/entrypoint.sh"]
