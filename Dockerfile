FROM python:3.6-alpine
RUN apk update
# Install base and dev packages
RUN apk add --no-cache --virtual .build-deps
RUN apk add bash
# Install build packages
RUN apk add make && apk add openssh && apk add bash
# Install git
RUN apk add git
RUN apk add zip
RUN apk add docker-cli

RUN pip install awsebcli==3.14.5
RUN pip install awscli