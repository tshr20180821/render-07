FROM php:8.3-apache

EXPOSE 80

SHELL ["/bin/bash", "-c"]

WORKDIR /usr/src/app

ENV CFLAGS="-O2 -march=native -mtune=native -fomit-frame-pointer"
ENV CXXFLAGS="$CFLAGS"
# ENV LDFLAGS="-fuse-ld=gold"
ENV AR_FLAGS="cr"

COPY ./php.ini ${PHP_INI_DIR}/

COPY --chmod=755 ./gnupg.sh ./
COPY ./src/*.java ./

ENV SQLITE_JDBC_VERSION="3.44.0.0"

RUN apt-get -qq update >/dev/null \
 && DEBIAN_FRONTEND=noninteractive time apt-get install -y --no-install-recommends \
  build-essential \
  bzip2 \
  default-jdk-headless \
  file \
  libsqlite3-0 \
  libevent-dev \
  libsasl2-dev \
  netcat-openbsd \
  ssh \
  >/dev/null \
 && BUILD_CANCEL=1 time ./gnupg.sh >/dev/null \
 && cp /usr/src/app/gnupg/bin/gpg /var/www/html/ \
 && time ./gnupg.sh -C \
 && ls -lang /usr/src/app/gnupg/bin/ \
 && echo "https://github.com/xerial/sqlite-jdbc/releases/download/$SQLITE_JDBC_VERSION/sqlite-jdbc-$SQLITE_JDBC_VERSION.jar" >download.txt \
 && echo "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.9/slf4j-api-2.0.9.jar" >>download.txt \
 && echo "https://repo1.maven.org/maven2/org/slf4j/slf4j-nop/2.0.9/slf4j-nop-2.0.9.jar" >>download.txt \
 && time xargs -P3 -n1 curl -sS -LO <download.txt \
 && time javac *.java \
 && mv ./AvailableProcessors.class /var/www/html/ \
 && time jar cfe LogOperation.jar LogOperationMain *.class \
 && cp ./LogOperation.jar /var/www/html/ \
 && time apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY ./test.php ./
COPY --chmod=755 ./build_memcached.sh ./
COPY ./*.c ./
COPY ./Dockerfile ./
COPY ./start.sh ./

COPY --from=memcached:latest /usr/local/bin/memcached ./

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
