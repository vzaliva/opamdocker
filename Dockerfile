FROM ubuntu:14.04

MAINTAINER Vadim Zaliva <lord@crocodile.org>

ENV DEBIAN_FRONTEND noninteractive

# OPTIONAL: Use AWS mirrors. Comment out next line if you building outside of AWS east
RUN sed 's@archive.ubuntu.com@us-east-1.ec2.archive.ubuntu.com@' -i /etc/apt/sources.list
RUN apt-get -y update -qq
RUN apt-get upgrade -y

RUN apt-get -y install -qq sudo pkg-config git build-essential software-properties-common

# Install OPAM
#See https://opam.ocaml.org/doc/Install.html#Ubuntu
RUN echo "yes" | add-apt-repository ppa:avsm/ppa
RUN apt-get -y update -qq
RUN apt-get -y install -qq ocaml ocaml-native-compilers camlp4-extra aspcud opam m4 darcs mercurial

#Install application
RUN useradd -ms /bin/bash opam
COPY ./src /home/opam/src

COPY ./assets/profile /home/opam/.profile
COPY ./assets/ocamlinit /home/opam/.ocamlinit
RUN chown -R opam:opam /home/opam/.profile /home/opam/.ocamlinit /home/opam/src
RUN chmod a+rx /home/opam/.profile
RUN chmod a+r  /home/opam/.ocamlinit

USER opam
ENV HOME /home/opam
ENV OPAMVERBOSE 0
ENV OPAMYES 1

WORKDIR /home/opam
RUN opam init

RUN opam install batteries omake

WORKDIR /home/opam/src
RUN /bin/bash -l -c "omake"

CMD ["./hello"]
