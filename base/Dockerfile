FROM debian:stretch
# FROM https://github.com/sharelatex/sharelatex-docker-image/blob/master/Dockerfile-base
LABEL maintainer="matthieu.simonin@inria.fr"

RUN set -eux; \
	apt-get update; \
	apt-get install -y gosu; \
	rm -rf /var/lib/apt/lists/*; \
# verify that the binary works
	gosu nobody true

RUN apt-get update
RUN apt-get install -y\
    build-essential\
    curl\
    wget\
    unzip\
    time\
    imagemagick\
    optipng\
    strace\
    nginx\
    git\
    python\
    zlib1g-dev\
    libpcre3-dev\
    aspell\
    aspell-en\
    aspell-es\
    aspell-fr\
    # Note: qpdf : runs on the host and optimize the pdf
    qpdf

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g grunt-cli

RUN mkdir -p /opt
WORKDIR /opt

RUN git clone https://gitlab.inria.fr/sed-rennes/sharelatex/sharelatex
WORKDIR sharelatex
RUN git checkout inria-1.2.1
RUN npm install

# default config file
RUN mkdir -p /etc/sharelatex
ADD settings.coffee /etc/sharelatex/settings.coffee

COPY entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

# Add sharelatex user
RUN groupadd sharelatex -g 15000
RUN useradd --shell /bin/bash -u 15000 -g 15000 -o -c "" -m sharelatex
RUN chown sharelatex:sharelatex -R /opt/sharelatex || true
RUN sync

USER sharelatex