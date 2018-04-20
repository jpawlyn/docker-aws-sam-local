# cnadiminti was original maintainer if you want your own docker image then
# replace with your Docker repo name
# REPO := cnsadiminti
REPO := xevo
CMD := docker run -it --rm \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v "$(PWD)/example":/var/opt \
	-p "3000:3000" \
	$(REPO)/aws-sam-local

help:
	@$(CMD)

validate:
	@$(CMD) validate

local-generate-event:
	@$(CMD) local generate-event api > ./example/event.json

local-invoke: gen-event
	@$(CMD) local invoke -e event.json --docker-volume-basedir "$(PWD)/example"

local-start-api:
	@$(CMD) local start-api --docker-volume-basedir "$(PWD)/example" --host 0.0.0.0

build:
	docker build -t $(REPO)/aws-sam-local .
