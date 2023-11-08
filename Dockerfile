FROM httpd:latest

WORKDIR /usr/src/app

COPY --chmod=755 ./gnupg.sh ./
COPY ./src/*.java ./

RUN apt-get update >/dev/null \
 && apt-get install -y --no-install-recommends bzip2 curl default-jdk gcc make >/dev/null \
 && ./gnupg.sh >/dev/null \
 && cp /usr/src/app/gnupg/bin/gpg /usr/local/apache2/htdocs/ \
 && ./gnupg.sh -c \
 && ./gnupg.sh -C \
 && ls -lang /usr/src/app/gnupg/bin/ \
 && curl -L -O https://github.com/xerial/sqlite-jdbc/releases/download/3.43.2.0/sqlite-jdbc-3.43.2.0.jar \
 && curl -L -O https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.9/slf4j-api-2.0.9.jar \
 && curl -L -O https://repo1.maven.org/maven2/org/slf4j/slf4j-nop/2.0.9/slf4j-nop-2.0.9.jar \
 && javac *.java \
 && jar cfe LogOperation.jar LogOperationMain *.class \
 && ls -lang \
 && apt-get purge -y --auto-remove bzip2 gcc make default-jdk \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY ./start.sh ./

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
