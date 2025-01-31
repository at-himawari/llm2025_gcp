# python base 3.11
FROM --platform=linux/amd64 python:3.11

# open-webui をインストール（タイムアウトとリトライ回数を設定）
RUN pip3 install --default-timeout=100 --retries=5 open-webui

# ポートの設定
EXPOSE 8080

CMD ["open-webui","serve"]