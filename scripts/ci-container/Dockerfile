# This image is used in the cdist-contrib CI for linting and generating the
# documentation.
FROM fedora:latest
MAINTAINER Timothée Floure <fnux@ungleich.ch>

RUN dnf install -y git findutils make python3-sphinx python3-sphinx_rtd_theme \
			ShellCheck openssh-clients
