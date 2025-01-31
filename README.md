# 前提
- Google Cloudのアカウント作成済み
- gcloudコマンドが利用可能
- Artifact Registryに、ollama-elyza-jp-8b-ggufとopen-webuiのリポジトリが存在する(空でOK)

# デプロイ手順
- backend
    - ```
      docker build -t ollama-elyza-jp-8b-gguf:latest .
        
      docker tag ollama-elyza-jp-8b-gguf asia-northeast1-docker.pkg.dev/プロジェクトID/ollama-elyza-jp-8b-gguf/ollama-elyza-jp-8b-gguf:latest
        
        docker push asia-northeast1-docker.pkg.dev/プロジェクトID/ollama-elyza-jp-8b-gguf/ollama-elyza-jp-8b-gguf:latest
      ```
- frontend
    - ```
      docker build -t open-webui:latest .
       
       docker tag open-webui:latest asia-northeast1-docker.pkg.dev/llm-experiment-449507/open-webui/open-webui:latest

        docker push asia-northeast1-docker.pkg.dev/llm-experiment-449507/open-webui/open-webui:latest

      ```