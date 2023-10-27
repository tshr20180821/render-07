FROM httpd:latest

WORKDIR /usr/src/app

RUN apt-get -q update \
 && apt-get -q install -y --no-install-recommends curl binutils gcc make bzip2 \
 && curl -O https://raw.githubusercontent.com/skeeto/lean-static-gpg/master/build.sh \
 && chmod +x build.sh \
 && ./build.sh \
 && cp /usr/src/app/gnupg/bin/gpg /usr/local/apache2/htdocs/ \
 && ./build.sh -c \
 && ./build.sh -C

COPY ./start.sh /usr/src/app/

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
