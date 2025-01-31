# 基盤となるイメージを選択
FROM --platform=linux/amd64 ubuntu:20.04

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Ollamaをインストールするためのリポジトリを追加
RUN curl -fsSL https://ollama.com/install.sh | sh

# 必要に応じてOllamaのバージョン確認や動作確認コマンドを追加できます
RUN ollama --version

# ポートの設定
EXPOSE 11434

# Ollamaを実行するためのエントリポイント（またはコマンド）を設定
CMD ["ollama","run","hf.co/elyza/Llama-3-ELYZA-JP-8B-GGUF"]