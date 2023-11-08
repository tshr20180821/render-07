FROM httpd:latest

WORKDIR /usr/src/app

ENV CFLAGS="-O2 -march=native -mtune=native -fomit-frame-pointer"
ENV CXXFLAGS="$CFLAGS"
ENV LDFLAGS="-fuse-ld=gold"

COPY --chmod=755 ./gnupg.sh ./
COPY ./src/*.java ./

RUN apt-get -q update \
 && apt-get install -y --no-install-recommends bzip2 gcc make default-jdk \
 && ./gnupg.sh \
 && cp /usr/src/app/gnupg/bin/gpg /usr/local/apache2/htdocs/ \
 && ./gnupg.sh -c \
 && ./gnupg.sh -C \
 && ls -lang /usr/src/app/gnupg/bin/ \
 && javac *.java \
 && ls -lang \
 && apt-get purge -y --auto-remove bzip2 gcc make default-jdk \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY ./start.sh ./

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
