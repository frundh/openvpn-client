FROM alpine
RUN apk add bash unrar
COPY ./crontabs /etc/crontabs/root
COPY ./unrar.sh /bin/unrar.sh
RUN chmod +x /bin/unrar.sh
CMD ["crond", "-f", "-d", "8"]
