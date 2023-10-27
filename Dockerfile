FROM apache:latest

WORKDIR /usr/src/app

RUN curl -O https://raw.githubusercontent.com/skeeto/lean-static-gpg/master/build.sh \
 && chmod +x build.sh \
 && ./build.sh

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
