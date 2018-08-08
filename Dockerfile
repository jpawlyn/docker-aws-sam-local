FROM alpine:3.8

# awscli for "sam package" and "sam deploy"
RUN apk add bash && apk add build-base && apk add alpine-sdk && sudo apk add python2-dev && apk add --no-cache py-pip && pip install awscli && pip install aws-sam-cli

WORKDIR /var/opt

EXPOSE 3000

# ENTRYPOINT ["/usr/local/bin/sam"]
