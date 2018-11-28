FROM registry.gitlab.inria.fr/sed-rennes/sharelatex/inria-docker-sharelatex/base:inria-1.2.1
# FROM https://github.com/sharelatex/sharelatex-docker-image/blob/master/Dockerfile-base
LABEL maintainer="matthieu.simonin@inria.fr"


# in sharelatex dir
RUN grunt install:web

WORKDIR web

RUN npm install
RUN grunt install

# specific steps for web
RUN npm install bcrypt
RUN cd modules && git clone https://bitbucket.org/sharelatex/launchpad-webmodule.git launchpad

# compile js and assets
RUN grunt compile
RUN grunt compile:minify
