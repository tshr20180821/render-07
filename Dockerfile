FROM httpd:latest

WORKDIR /usr/src/app

RUN apt-get -q update \
 && apt-get -q install -y --no-install-recommends curl gcc make bzip2 libgpg-error-dev

COPY ./gnupg.sh ./

RUN chmod +x gnupg.sh \
 && cat ./gnupg.sh \
 && ./gnupg.sh

RUN cp /usr/src/app/gnupg/bin/gpg /usr/local/apache2/htdocs/ \
 && ./gnupg.sh -c \
 && ./gnupg.sh -C \
 && ls -lang /usr/src/app/gnupg/bin/

COPY ./start.sh ./

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
