FROM httpd:latest

WORKDIR /usr/src/app

COPY ./gnupg.sh ./

RUN apt-get -q update \
 && apt-get -q install -y --no-install-recommends curl gcc make bzip2 \
 && chmod +x build.sh \
 && ./build.sh \
 && cp /usr/src/app/gnupg/bin/gpg /usr/local/apache2/htdocs/ \
 && ./build.sh -c \
 && ./build.sh -C

COPY ./start.sh ./

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
