FROM debian:jessie

MAINTAINER Matthieu Simonin <matthieu.simonin@inria.fr>

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING UTF-8

RUN apt-get update -qq && apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  wget\
  sudo\
  perl\
  python-pygments

# Install TexLive
RUN apt-get install -y wget
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz; \
  mkdir /install-tl-unx; \
  tar -xvf install-tl-unx.tar.gz -C /install-tl-unx --strip-components=1

RUN echo "selected_scheme scheme-full" >> /install-tl-unx/texlive.profile; \
  /install-tl-unx/install-tl -profile /install-tl-unx/texlive.profile
RUN rm -r /install-tl-unx; \
  rm install-tl-unx.tar.gz

# The path will persist.
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/texlive/2015/bin/x86_64-linux/
RUN tlmgr install latexmk


# Install Aspell
RUN apt-get install -y aspell aspell-en aspell-fr aspell-es
