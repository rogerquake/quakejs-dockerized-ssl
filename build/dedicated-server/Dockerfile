FROM node:12-alpine
RUN apk add --no-cache git
WORKDIR /app
RUN git clone https://github.com/rogerquake/quakejs.git .
RUN git submodule update --init
RUN sed -i '/"quakejs-files"/d' package.json 2>/dev/null || true
RUN npm install
# Fix DirtyInstallers callback bug — prevents crash on startup
RUN for F in /app/build/ioquake3_secure.js /app/build/ioq3ded_secure.js; do \
    [ -f "$F" ] && sed -i 's/return callback(/return (typeof callback === "function") \&\& callback(/g' "$F"; \
    done
COPY ./entrypoint.sh /app/entrypoint.sh
RUN chmod +rx /app/entrypoint.sh
ENV Q3JS_DOMAIN=content.quakejs.com
ENV Q3JS_SERVER_RESTART_HOURS=8
ENV Q3JS_SERVER_GAMEMODE=baseq3
ENV Q3JS_SERVER_DEDICATED=1
EXPOSE 27960
CMD [ "sh", "/app/entrypoint.sh" ]
