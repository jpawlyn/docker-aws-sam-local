
# docker-aws-sam-local

This is the source repository of the [Docker image](https://hub.docker.com/r/cnadiminti/aws-sam-local/) for [Amazon AWS SAM Local](https://github.com/awslabs/aws-sam-local).

## Supported tags and respective `Dockerfile` links
-	[`latest` (*latest/Dockerfile*)](Dockerfile)
- [`0.2.2` (*0.2.2/Dockerfile*)](Dockerfile)
- [`0.2.8` (*0.2.8/Dockerfile*)](Dockerfile)

For more up to date images go to https://docker.com/u/xevo/aws-sam-local or just
search the Docker Hub


## What is AWS SAM Local?

[Amazon AWS SAM Local](https://github.com/awslabs/aws-sam-local) is a tool for local development and testing of Serverless applications. It can be used to test functions locally, start a local API Gateway from a SAM template, validate a SAM template, and generate sample payloads for various event sources.

## How to use this image?
First of course you need to install docker on your system. And then fork this
repo and customize that Makefile with the location of 

- BASEDIR. This is the location of your AWS Lamdbda and by default it is pointed
  at the (example)[example] directory in this repo. You will want to shift this
to where your lambda actually lives when you fork this repo. Alternatively, if
you don't want to change BASEDIR, you could also edit the
[example/template.yaml] file and change the
AWS::Serverless::Function::Properties::Handler::Path to whereever on the local
system you have your lambda code
- REPO. This is the location of the docker repo where the dockerfile lives, it
  defaults to the image stored on hub.docker.io/r/xevo right now, so adjust this
if you want your own private docker image

If you want to run this raw and add your own commands then run this. The two key
ideas here are to link the docker management in the container with the host.
This is because SAM local actually runs as a docker container so the
aws-sam-local container needs to control other containers.

The second is that by default aws-sam-local assumes that the lambda files are in
the same directory in which is was installed.

## Docker Compose sample file
This implements the same thing as the Makefile, it boots the docker image and
points it to the [example] directory by default so feel free to change this and
add this to your more complete docker compose.

## Running from the console

```console
$ docker run -it --rm \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v "$(PWD)":/var/opt \
	-p "3000:3000" \
	xevo/aws-sam-local

```

This will add your current directory as a volume to the container and publish host port to container port.

For working examples please take a look at the [`Makefile`](Makefile) and [`docker-compose.yaml`](/docker-compose.yaml) files in the source repository. Note that `PWD` above should resolve to a path on the host (the machine running Docker), not something within a Docker container.

## License

- [Amazon AWS SAM Local License Agreement](https://github.com/awslabs/aws-sam-local/blob/master/LICENSE)


## User Feedback

### Issues

If you have any problems with or questions about this image, please contact us through a GitHub issue

### Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a GitHub, especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
