IMAGE_NAME ?= srsolutions/ilias

PLATFORM ?= linux/amd64,linux/arm64
OUTPUT ?= type=image,push=true

IMAGES = \
	7/php7.3-apache \
	7/php7.4-apache \
	8/php7.4-apache \
	8/php8.0-apache \
	9/php8.1-apache \
	9/php8.2-apache \
	10-beta/php8.2-apache \
	10-beta/php8.3-apache

LATEST = 9/php8.2-apache

variant = $$(basename $1)
branch  = $$(basename $$(dirname $1))
tag     = $$(echo $1 | sed 's|/|-|')
version = $$(grep "ENV ILIAS_VERSION" $1/Dockerfile | awk -F "=" '{print $$2}')

.ONESHELL:
.SILENT:

all: $(IMAGES) tag

.PHONY: $(IMAGES)
$(IMAGES):
	variant=$(call variant,$@)
	branch=$(call branch,$@)
	version=$(call version,$$branch)
	echo "Building $(IMAGE_NAME):$$branch-$$variant (version $$version)"
	docker buildx build --platform $(PLATFORM) --pull \
		-f $$branch/Dockerfile \
		--build-arg ILIAS_BASE_IMAGE=$$branch-$$variant \
		-t $(IMAGE_NAME):$$branch-$$variant \
		-t $(IMAGE_NAME):$$version-$$variant \
		--output $(OUTPUT) \
		.

.PHONY: tag
tag:
	tag () {
		case "${OUTPUT}" in
			*push=false*)
				docker tag $$1 $$2
				;;
			*push=true*)
				docker buildx imagetools create $$1 --tag $$2
				;;
			esac
	}
	for i in $(IMAGES); do \
		variant=$(call variant,$$i);
		branch=$(call branch,$$i);
		tag=$(call tag,$$i);
		echo "Tagging $(IMAGE_NAME):$$tag as $(IMAGE_NAME):$$branch"; \
		tag $(IMAGE_NAME):$$tag $(IMAGE_NAME):$$branch; \
	done
	latest=$(IMAGE_NAME):$(call tag,$(LATEST))
	echo "Tagging $$latest as latest"
	tag $$latest $(IMAGE_NAME):latest

local: PLATFORM=local
local: export BUILDX_BUILDER=default
local: OUTPUT=type=image,push=false
local: all

.PHONY: pull
pull:
	for i in $(IMAGES); do \
		variant=$(call variant,$$i);
		branch=$(call branch,$$i);
		tag=$(call tag,$$i);
		version=$(call version,$$branch); \
		echo "Pulling $(IMAGE_NAME):$$tag"; \
		docker pull $(IMAGE_NAME):$$tag; \
		echo "Pulling $(IMAGE_NAME):$$branch"; \
		docker pull $(IMAGE_NAME):$$branch; \
		echo "Pulling $(IMAGE_NAME):$$version-$$variant"; \
		docker pull $(IMAGE_NAME):$$version-$$variant; \
	done
	echo "Pulling $(IMAGE_NAME):latest"
	docker pull $(IMAGE_NAME):latest
