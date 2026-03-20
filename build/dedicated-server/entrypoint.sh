cd /app
Q3JS_SERVER_RESTART_SECONDS=$(($Q3JS_SERVER_RESTART_HOURS*60*60))
while true
do
    if [ "$Q3JS_SERVER_RESTART_HOURS" = "0" ]; then
        echo "[Dedicated Server] 🟢 Running indefinitely (restart disabled)."
        node build/ioq3ded_secure.js +set fs_game "$Q3JS_SERVER_GAMEMODE" +set dedicated $Q3JS_SERVER_DEDICATED +set fs_cdn "$Q3JS_DOMAIN" +exec server.cfg
    else
        echo "[Dedicated Server] 🟢 The server will be automatically restarted after $Q3JS_SERVER_RESTART_HOURS-hours."
        timeout $Q3JS_SERVER_RESTART_SECONDS node build/ioq3ded_secure.js +set fs_game "$Q3JS_SERVER_GAMEMODE" +set dedicated $Q3JS_SERVER_DEDICATED +set fs_cdn "$Q3JS_DOMAIN" +exec server.cfg
    fi
    echo "[Dedicated Server] 🔴 Server stopped. Restarting..."
    sleep 5
done
