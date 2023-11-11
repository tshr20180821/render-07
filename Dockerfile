FROM httpd:latest

WORKDIR /usr/src/app

ENV CFLAGS="-O2 -march=native -mtune=native -fomit-frame-pointer"
ENV CXXFLAGS="$CFLAGS"
ENV AR_FLAGS="cr"

COPY --chmod=755 ./gnupg.sh ./
COPY ./src/*.java ./

RUN apt-get -q update >/dev/null \
 && apt-get install -y --no-install-recommends apt-utils bzip2 curl default-jdk-headless gcc make time >/dev/null \
 && time ./gnupg.sh >/dev/null \
 && cp /usr/src/app/gnupg/bin/gpg /usr/local/apache2/htdocs/ \
 && time ./gnupg.sh -c \
 && ./gnupg.sh -C \
 && ls -lang /usr/src/app/gnupg/bin/ \
 && time curl -L -O https://github.com/xerial/sqlite-jdbc/releases/download/3.43.2.2/sqlite-jdbc-3.43.2.2.jar \
 && time curl -L -O https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.9/slf4j-api-2.0.9.jar \
 && time curl -L -O https://repo1.maven.org/maven2/org/slf4j/slf4j-nop/2.0.9/slf4j-nop-2.0.9.jar \
 && time javac *.java \
 && mv ./AvailableProcessors.class /usr/local/apache2/htdocs/ \
 && time jar cfe LogOperation.jar LogOperationMain *.class \
 && mv ./LogOperation.jar /usr/local/apache2/htdocs/ \
 && ls -lang \
 && time apt-get purge -y --auto-remove bzip2 gcc make default-jdk-headless >/dev/null \
 && time apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY ./start.sh ./

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
