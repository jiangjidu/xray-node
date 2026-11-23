FROM ghcr.io/xtls/xray-core:latest AS src
FROM alpine:latest
RUN apk add --no-cache ca-certificates tzdata
COPY --from=src /usr/local/bin/xray /usr/local/bin/xray
COPY config.json.template /usr/local/etc/xray/config.json.template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 3000
ENTRYPOINT ["/entrypoint.sh"]
