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
# ※ollama serveは永続的に起動するため、バックグラウンドで起動し、
#    curlでポートが開いているか確認した後、モデルのダウンロードを実行し、
#    最後にサーバーを停止するという流れにしています。
RUN set -ex; \
    # サーバーをバックグラウンドで起動
    ollama serve & \
    SERVER_PID=$!; \
    echo "Waiting for ollama serve to be ready..."; \
    # ポート11434にHTTPリクエストが通るまでループ（タイムアウトは適宜調整してください）
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

# builderステージからOllamaのバイナリとキャッシュ（モデルデータ）をコピー
COPY --from=builder /usr/local/bin/ollama /usr/local/bin/ollama
COPY --from=builder /root/.ollama /root/.ollama

# 必要なポートの公開（※Cloud Runでは環境変数PORTが指定されることが多いですが、
# 今回はローカル検証用として11434を利用）
EXPOSE 11434

# コンテナ起動時はollama serveでサーバーを起動
CMD ["ollama", "serve"]
