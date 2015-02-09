From ubuntu:14.04

#apt Bescheid sagen:
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get --yes update
RUN apt-get --yes upgrade

RUN apt-get --yes install software-properties-common
RUN add-apt-repository --yes ppa:bartbes/love-stable

run apt-get --yes install love make zip

volume /src
workdir /src
cmd ./build.sh
