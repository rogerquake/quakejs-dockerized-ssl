#!/bin/sh

echo "[Dedicated Server] Waiting for 30 seconds until all services are ready..."
sleep 30

Q3JS_DOMAIN="$Q3JS_DOMAIN:9000"

echo "[Dedicated Server] Start-up info:"
echo "Content Server: $Q3JS_DOMAIN"
echo "Gamemode: $Q3JS_SERVER_GAMEMODE"
echo "Dedicated: $Q3JS_SERVER_DEDICATED"

cd /app

Q3JS_SERVER_RESTART_SECONDS=$(($Q3JS_SERVER_RESTART_HOURS*60*60))

while true
do
    echo "[Dedicated Server] 🟢 The server will be automatically restarted after $Q3JS_SERVER_RESTART_HOURS-hours."
    timeout $Q3JS_SERVER_RESTART_SECONDS node build/ioq3ded_secure.js +set fs_game "$Q3JS_SERVER_GAMEMODE" +set dedicated $Q3JS_SERVER_DEDICATED +set fs_cdn "$Q3JS_DOMAIN" +exec server.cfg
    echo "[Dedicated Server] 🔄 Restarting..."
done
