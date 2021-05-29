FROM alpine:3

RUN apk add --no-cache openssl
COPY lib/* VERSION /usr/lib/certgen/
COPY bin/certgen.sh /usr/bin/certgen
RUN chmod -R 0100 /usr/lib/certgen /usr/bin/certgen

COPY test /tmp/test
RUN sh /tmp/test/run.sh

WORKDIR /certs
VOLUME /certs
ENTRYPOINT ["/usr/bin/certgen"]
CMD ["--help"]
