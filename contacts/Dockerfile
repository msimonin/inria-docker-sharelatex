FROM registry.gitlab.inria.fr/sed-rennes/sharelatex/inria-docker-sharelatex/base:inria-1.2.1
# FROM https://github.com/sharelatex/sharelatex-docker-image/blob/master/Dockerfile-base
LABEL maintainer="matthieu.simonin@inria.fr"


# in sharelatex dir
RUN grunt install:contacts

WORKDIR contacts

RUN npm install
RUN grunt install
