# 
##
## Builds a docker container that hosts AWS Serverless Application Model on your local machine
## See https://docs.aws.amazon.com/lambda/latest/dg/test-sam-local.html#
## 
#
# cnadiminti was original maintainer if you want your own docker image then
# replace with your Docker repo name
# REPO := cnsadiminti
REPO := xevo
IMAGE := aws-sam-local
VERSION := 0.2.8
BASEDIR := "$(PWD)/example"
## 
## Assumes your lambda template and source code set in Makefile variable BASEDIR
## And that you the docker repo is REPO as IMAGE
##

# Note the docker container needs the actual lambda in /var/opt
CMD := docker run -it --rm \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v "$(BASEDIR)":/var/opt \
	-p "3000:3000" \
	$(REPO)/aws-sam-local

# https://swcarpentry.github.io/make-novice/08-self-doc/ is simpler just need ##
# and it dumps them out relies on the variable MAKEFILE_LIST which is a list of
# all files note we do not just use $< because this is an include.mk file 
# Use double hashtags to print help out
# Add to the MAKEFILE_LIST if you are using Makefile includes
MAKEFILE_LIST := Makefile
help: $(MAKEFILE_LIST)
	@sed -n 's/^##//p' $(MAKEFILE_LIST)

## help-sam: Information on sam commands
help-sam:
	@$(CMD)

## local: Information on sam local commands
local:
	@$(CMD) local

## validate: checks by default example/template.yaml, edit to add your lambda which handles all api requests
validate:
	@$(CMD) validate

## start-api: creates local http server hosting all your lambda found at template.yaml/AWS::Serverless::Function::CodeUri 
##            run this in a separate window so you can see errors
start-api:
	@$(CMD) local start-api --docker-volume-basedir "$(BASEDIR)" --host 0.0.0.0

## invoke: runs your lamdba locally by posting the file example/event.json
invoke: generate-event
	@$(CMD) local invoke -e event.json --docker-volume-basedir "$(BASEDIR)"

## generate-event: generates an API Gateway event and puts result into example/event.out.json
generate-event:
	@$(CMD) local generate-event api > $(BASEDIR)/event.out.json

## builds the docker container and pushes it into $(REPO)/$(IMAGE)
build:
	docker build -t $(REPO)/$(IMAGE) . 
	docker tag $(REPO)/$(IMAGE):latest $(REPO)/$(IMAGE):$(VERSION)
	docker push $(REPO)/$(IMAGE)

##
