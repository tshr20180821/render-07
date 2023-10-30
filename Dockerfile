FROM httpd:latest

WORKDIR /usr/src/app

COPY --chmod=755 ./gpg /tmp/
RUN apt-get -q update \
 && apt-get install curl \
 && echo "deb [signed-by=/etc/apt/keyrings/apt-fast.gpg] http://ppa.launchpad.net/apt-fast/stable/ubuntu jammy main" | tee /etc/apt/sources.list.d/apt-fast.list \
 && mkdir -p /etc/apt/keyrings
RUN curl -vvvkL 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xA2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B'
RUN curl -fsSL https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xA2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B | /tmp/gpg --dearmor -o /etc/apt/keyrings/apt-fast.gpg \
 && apt-get update \
 && apt-get install apt-fast

# RUN apt-get -q update \
#  && apt-get -q install -y --no-install-recommends curl gcc make bzip2

# COPY ./gnupg.sh ./

# RUN chmod +x gnupg.sh \
#  && cat ./gnupg.sh \
#  && ./gnupg.sh

# RUN cp /usr/src/app/gnupg/bin/gpg /usr/local/apache2/htdocs/ \
#  && ./gnupg.sh -c \
#  && ./gnupg.sh -C \
#  && ls -lang /usr/src/app/gnupg/bin/

COPY ./start.sh ./

ENTRYPOINT ["bash","/usr/src/app/start.sh"]
