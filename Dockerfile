FROM httpd:latest

WORKDIR /usr/src/app

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl binutils \
 && curl -O https://raw.githubusercontent.com/skeeto/lean-static-gpg/master/build.sh \
 && chmod +x build.sh \
 && ./build.sh

COPY ./start.sh /usr/src/app/

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
