FROM debian:testing

MAINTAINER Matthieu Simonin <matthieu.simonin@inria.fr>


RUN apt-get update -qq && apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  wget\
  sudo\
  perl\
  python-pygments\
  libfontconfig # required by xelatex

# Install TexLive
RUN apt-get install -y wget
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz; \
  mkdir /install-tl-unx; \
  tar -xvf install-tl-unx.tar.gz -C /install-tl-unx --strip-components=1

RUN echo "selected_scheme scheme-full" > /install-tl-unx/texlive.profile;
RUN echo "option_doc 0" >> /install-tl-unx/texlive.profile;
RUN /install-tl-unx/install-tl -profile /install-tl-unx/texlive.profile
RUN rm -r /install-tl-unx; \
  rm install-tl-unx.tar.gz


# The path will persist.
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/texlive/2019/bin/x86_64-linux/
RUN tlmgr install latexmk
RUN tlmgr install texcount
RUN tlmgr install chktex

# Install Aspell
RUN apt-get install -y aspell aspell-en aspell-fr aspell-es

# ghostscript is used for instance when eps are included in source
# it will convert them to pdf
RUN apt-get install -y ghostscript

## Install dot2tex
RUN apt-get install -y python-pip graphviz
RUN pip install dot2tex
RUN tlmgr install xkeyval
RUN tlmgr install moreverb

# some fonts
cp $(kpsewhich -var-value TEXMFSYSVAR)/fonts/conf/texlive-fontconfig.conf /etc/fonts/conf.d/09-texlive.conf
wget http://jorrel.googlepages.com/Monaco_Linux.ttf -O /usr/share/fonts/truetype/Monaco/Monaco_Linux.ttf
sudo fc-cache -fsv

# fix locale
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING UTF-8

# Keep env while using sudo inside the docker
RUN sed -i /secure_path/d /etc/sudoers

