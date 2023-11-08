FROM httpd:latest

WORKDIR /usr/src/app

COPY --chmod=755 ./gpg /tmp/
COPY ./apt-fast.conf /tmp/
RUN apt-get -q update \
 && apt-get install  -y --no-install-recommends curl \
 && echo "deb [signed-by=/etc/apt/keyrings/apt-fast.gpg] http://ppa.launchpad.net/apt-fast/stable/ubuntu jammy main" | tee /etc/apt/sources.list.d/apt-fast.list \
 && mkdir -p /etc/apt/keyrings \
 && curl -fsSL 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xA2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B' | /tmp/gpg --dearmor -o /etc/apt/keyrings/apt-fast.gpg \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-fast \
 && cp -f /tmp/apt-fast.conf /etc/ \
 && apt-fast install -y --no-install-recommends bzip2 gcc make \
 && cat /etc/apt-fast.conf

COPY --chmod=755 ./gnupg.sh ./

RUN cat ./gnupg.sh \
 && ./gnupg.sh \
 && cp /usr/src/app/gnupg/bin/gpg /usr/local/apache2/htdocs/ \
 && ./gnupg.sh -c \
 && ./gnupg.sh -C \
 && ls -lang /usr/src/app/gnupg/bin/ \
 && apt-get purge -y --auto-remove apt-fast bzip2 gcc make \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY ./start.sh ./

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
