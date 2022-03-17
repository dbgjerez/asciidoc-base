FROM asciidoctor/docker-asciidoctor

RUN ls -lch /documents

ARG USER_UID=1
RUN addgroup -S asciidoctor && adduser -u $USER_UID -S builder -G asciidoctor

USER builder

RUN id