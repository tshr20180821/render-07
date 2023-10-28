FROM httpd:latest

WORKDIR /usr/src/app

COPY ./gnupg.sh ./

RUN apt-get -q update \
 && apt-get -q install -y --no-install-recommends curl gcc make bzip2 \
 && chmod +x gnupg.sh \
 && ./gnupg.sh \
 && cp /usr/src/app/gnupg/bin/gpg /usr/local/apache2/htdocs/ \
 && ./gnupg.sh -c \
 && ./gnupg.sh -C \
 && ls -lang /usr/src/app/gnupg/bin/

COPY ./start.sh ./

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
