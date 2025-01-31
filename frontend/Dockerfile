# python base 3.11
FROM --platform=linux/amd64 python:3.11

# open-webui
RUN pip install open-webui

# ポートの設定
EXPOSE 8080

CMD ["open-webui","serve"]