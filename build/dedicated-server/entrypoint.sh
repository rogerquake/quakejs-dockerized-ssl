cd /app
Q3JS_SERVER_RESTART_SECONDS=$(($Q3JS_SERVER_RESTART_HOURS*60*60))
# Build content server URL with port 9000 for dedicated server
# Q3JS_DOMAIN is just the hostname/IP — dedicated server needs explicit port
Q3JS_CDN_URL="https://${Q3JS_DOMAIN}:9000"
while true
do
    if [ "$Q3JS_SERVER_RESTART_HOURS" = "0" ]; then
        echo "[Dedicated Server] 🟢 Running indefinitely (restart disabled)."
        NODE_TLS_REJECT_UNAUTHORIZED=0 node build/ioq3ded_secure.js +set fs_game "$Q3JS_SERVER_GAMEMODE" +set dedicated $Q3JS_SERVER_DEDICATED +set fs_cdn "$Q3JS_CDN_URL" +exec server.cfg
    else
        echo "[Dedicated Server] 🟢 The server will be automatically restarted after $Q3JS_SERVER_RESTART_HOURS-hours."
        NODE_TLS_REJECT_UNAUTHORIZED=0 timeout $Q3JS_SERVER_RESTART_SECONDS node build/ioq3ded_secure.js +set fs_game "$Q3JS_SERVER_GAMEMODE" +set dedicated $Q3JS_SERVER_DEDICATED +set fs_cdn "$Q3JS_CDN_URL" +exec server.cfg
    fi
    echo "[Dedicated Server] 🔴 Server stopped. Restarting..."
    sleep 5
done
