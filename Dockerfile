FROM alpine
RUN apk update && apk add bash curl
ADD dynu-dns.sh /
CMD ["/dynu-dns.sh"]