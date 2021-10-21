# https://github.com/Envek/aws-sam-typescript-layers-example/blob/master/Makefile
# https://github.com/aws/aws-sam-cli/issues/3350
.PHONY: build-RuntimeDependenciesLayer build-lambda-common
.PHONY: build-hello build-world

build-hello:
	$(MAKE) HANDLER=src/handlers/hello.ts build-lambda-common

build-world:
	$(MAKE) HANDLER=src/handlers/world.ts build-lambda-common

build-helloListener:
	$(MAKE) HANDLER=src/handlers/helloListener.ts build-lambda-common
	

build-lambda-common:
	npm install
	rm -rf dist
	echo "{\"extends\": \"./tsconfig.json\", \"include\": [\"${HANDLER}\"] }" > tsconfig-only-handler.json
	npm run compile -- --build tsconfig-only-handler.json
	cp -r dist "$(ARTIFACTS_DIR)/"


build-RuntimeDependenciesLayer:
	mkdir -p "$(ARTIFACTS_DIR)/nodejs"
	cp package.json package-lock.json "$(ARTIFACTS_DIR)/nodejs/"
	npm install --production --prefix "$(ARTIFACTS_DIR)/nodejs/"
	rm "$(ARTIFACTS_DIR)/nodejs/package.json" # to avoid rebuilding when changes doesn't relate to dependencies