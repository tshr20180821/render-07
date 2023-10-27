FROM php:8.2-apache

WORKDIR /usr/src/app

RUN apt-get -q update \
 && apt-get -q install -y --no-install-recommends curl binutils gcc make bzip2 \
 && curl -O https://raw.githubusercontent.com/skeeto/lean-static-gpg/master/build.sh \
 && chmod +x build.sh \
 && ./build.sh \
 && ./build.sh -c \
 && ./build.sh -C

COPY ./start.sh /usr/src/app/

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
