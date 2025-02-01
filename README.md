# 前提
- Google Cloudのアカウント作成済み
- gcloudコマンドが利用可能
- Artifact Registryに、phi3とopen-webuiのリポジトリが存在する(空でOK)

# デプロイ手順
- backend
    - ```
      docker build -t phi3 .
        
      docker tag phi3 asia-northeast1-docker.pkg.dev/プロジェクトID/phi3/phi3:latest
        
      docker push asia-northeast1-docker.pkg.dev/プロジェクトID/phi3/phi3:latest
      ```
- frontend
    - ```
      docker build -t open-webui:latest .
       
      docker tag open-webui:latest asia-northeast1-docker.pkg.dev/llm-experiment-449507/open-webui/open-webui:latest

      docker push asia-northeast1-docker.pkg.dev/llm-experiment-449507/open-webui/open-webui:latest

      ```
    - 環境変数設定
      - OLLAMA_HOST:backendのURLを設定