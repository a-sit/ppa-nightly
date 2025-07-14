FROM debian:trixie-slim

#Update & upgrade
RUN apt-get update && apt-get upgrade -y && apt-get -y install curl gpg


RUN mkdir /asit-tester
WORKDIR /asit-tester
