FROM alpine:3.10
COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 entrypoint.sh
RUN apk update
RUN apk add --no-cache openssh sshpass
RUN apk add curl
RUN apk add wget
RUN apk add openssl
ENTRYPOINT ["/entrypoint.sh"]