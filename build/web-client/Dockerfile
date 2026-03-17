FROM node:12-alpine
RUN apk add --no-cache git jq
WORKDIR /app
RUN git clone https://github.com/rogerquake/quakejs.git .
RUN sed -i '/"quakejs-files"/d' package.json 2>/dev/null || true
RUN npm install
# Fix DirtyInstallers callback bug — prevents crash on startup
RUN for F in /app/build/ioquake3_secure.js /app/build/ioq3ded_secure.js; do \
    [ -f "$F" ] && sed -i 's/return callback(/return (typeof callback === "function") \&\& callback(/g' "$F"; \
    done
COPY ./entrypoint.sh /app/entrypoint.sh
RUN chmod +rx /app/entrypoint.sh
EXPOSE 80 443
CMD [ "sh", "/app/entrypoint.sh" ]
