#!/bin/bash

echo -e " "
echo -e "\033[0;34m────────────────────────────────────────────────────────────────\033[0m"
echo -e "\033[1;34m[Tunnel] Cloudflare Tunnel\033[0m"
echo -e "\033[1;34m[Tunnel] Originally created by Ym0t, modified by HHakeRR\033[0m"
echo -e "\033[1;34m[Tunnel] Check out the GitHub profiles:\033[0m"
echo -e "\033[4;34mhttps://github.com/Ym0T\033[0m"
echo -e "\033[4;34mhttps://github.com/HHakeRR785\033[0m"
echo -e "\033[0;34m────────────────────────────────────────────────────────────────\033[0m"
echo -e " "

if ! command -v /home/container/cloudflared &> /dev/null; then
    echo -e "\033[0;33m[Tunnel] Cloudflared not found! Downloading the latest version...\033[0m"
    
    curl -fsSL -o /home/container/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    && chmod +x /home/container/cloudflared \
    && echo -e "\033[0;32m[Tunnel] Cloudflared downloaded and ready!\033[0m" || { 
        echo -e "\033[0;31m[Tunnel] Error: Failed to download Cloudflared!\033[0m"; exit 1; 
    }
fi

if [ -s "/home/container/cloudflared_token.txt" ]; then
    echo -e "\033[0;37m[Tunnel] Starting Cloudflared with token\033[0m"

    /home/container/cloudflared tunnel --no-autoupdate run --token "$(cat /home/container/cloudflared_token.txt)" > /home/container/logs/cloudflared.log 2>&1 &
    CLOUD_FLARED_PID=$!

    echo $CLOUD_FLARED_PID > /home/container/tmp/cloudflared.pid

    MAX_ATTEMPTS=130
    ATTEMPT=0

    STATUS_TIMES=(5 10 15 30 60 90 120)

    echo -e "\033[0;33m[Tunnel] Waiting for Cloudflared to start...\033[0m"

    while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
        sleep 1
        ATTEMPT=$((ATTEMPT + 1))

        if [[ " ${STATUS_TIMES[@]} " =~ " $ATTEMPT " ]]; then
            echo -e "\033[0;33m[Tunnel] Still waiting... ($ATTEMPT sec)\033[0m"
        fi

        if ! kill -0 $CLOUD_FLARED_PID 2>/dev/null; then
            echo -e "\033[0;31m[Tunnel] Cloudflared failed to start. Check logs at /home/container/logs/cloudflared.log\033[0m"
            echo -e "\033[0;31m$(tail -n 10 /home/container/logs/cloudflared.log)\033[0m"
            exit 1
        fi

        if grep -qE "Registered tunnel connection|Updated to new configuration" /home/container/logs/cloudflared.log; then
            echo -e "\033[0;32m[Tunnel] Connected after $ATTEMPT seconds\033[0m"
            echo -e "\033[0;32m[Tunnel] Cloudflared is running successfully!\033[0m"
            exit 0
        fi
    done

    echo -e "\n\033[0;31m[Tunnel] Cloudflared did not confirm a successful connection. Check logs at /home/container/logs/cloudflared.log\033[0m"
    echo -e "\033[0;31m$(tail -n 10 /home/container/logs/cloudflared.log)\033[0m"
    exit 1

else
    echo -e "\033[0;31m[Tunnel] cloudflared_token.txt is empty or does not exist. Skipping Cloudflared startup.\033[0m"
fi