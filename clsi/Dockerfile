FROM registry.gitlab.inria.fr/sed-rennes/sharelatex/inria-docker-sharelatex/base:inria-1.2.1
# FROM https://github.com/sharelatex/sharelatex-docker-image/blob/master/Dockerfile-base
LABEL maintainer="matthieu.simonin@inria.fr"


# in sharelatex dir
RUN grunt install:clsi

WORKDIR clsi

RUN npm install
RUN grunt install
RUN grunt compile:bin

USER root
# from https://docs.docker.com/install/linux/docker-ce/debian/#set-up-the-repository
RUN apt-get install -y\
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

RUN apt-get update
RUN apt-get install -y docker-ce-cli

# Removing the entry point
# The clsi communicates with the host daemon using the docker sock
# The dynamic user created at container startup must thus be added also in the docker group
# (which doesn't exist in the clsi container)
# Risk are mitigated by the fact that compilation container are then using a
# user without priviledge
