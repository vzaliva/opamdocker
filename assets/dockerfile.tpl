FROM ubuntu:14.04

MAINTAINER Vadim Zaliva <lord@crocodile.org>

ENV DEBIAN_FRONTEND noninteractive

# Use AWS mirrors. Comment out next line if you building outside of AWS east
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
ADD ./src $SRCS_DIR/src

COPY ./assets/.profile $SRCS_DIR
COPY ./assets/.ocamlinit $SRCS_DIR
RUN chown -R opam:opam $SRCS_DIR/.profile $SRCS_DIR/.ocamlinit $SRCS_DIR/src
RUN chmod a+rx $SRCS_DIR/.profile
RUN chmod a+r  $SRCS_DIR/.ocamlinit

USER opam
ENV HOME $SRCS_DIR
ENV OPAMVERBOSE 0
ENV OPAMYES 1
WORKDIR $SRCS_DIR
RUN opam init

RUN opam install batteries
RUN opam install omake

WORKDIR $SRCS_DIR/src
RUN /bin/bash -l -c "omake"

CMD ["./hello"]
