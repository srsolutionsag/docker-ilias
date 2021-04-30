IMAGE_NAME ?= sturai/ilias

IMAGES = \
	5.3/php5.6-apache \
	5.3/php7.0-apache \
	5.3/php7.1-apache \
	5.4/php7.0-apache \
	5.4/php7.1-apache \
	5.4/php7.2-apache \
	5.4/php7.3-apache \
	6/php7.2-apache \
	6/php7.3-apache \
	6/php7.4-apache \
	7/php7.3-apache \
	7/php7.4-apache \
	8-alpha/php7.4-apache \
	8-alpha/php8.0-apache

LATEST = 7/php7.4-apache

variant = $$(basename $1)
branch  = $$(basename $$(dirname $1))
tag     = $$(echo $1 | sed 's|/|-|')
version = $$(grep "ENV ILIAS_VERSION" $1/Dockerfile | awk -F "=" '{print $$2}')
php     = $$(echo $1 | sed -E 's|.*php(.*)|\1|')

.ONESHELL:

all: $(IMAGES) tag

.PHONY: $(IMAGES)
$(IMAGES):
	@variant=$(call variant,$@)
	@branch=$(call branch,$@)
	@version=$(call version,$$branch)
	@php=$(call php,$$variant)
	@echo "Building $(IMAGE_NAME):$$branch-$$variant (version $$version)"
	docker build --rm --pull \
		-f $$branch/Dockerfile \
		--build-arg PHP_VERSION=$$php \
		-t $(IMAGE_NAME):$$branch-$$variant \
		-t $(IMAGE_NAME):$$version-$$variant \
		.

.PHONY: tag
tag: $(LATEST)
	@for i in $(IMAGES); do \
		variant=$(call variant,$$i);
		branch=$(call branch,$$i);
		tag=$(call tag,$$i);
		echo "Tagging $(IMAGE_NAME):$$tag as $(IMAGE_NAME):$$branch"; \
		docker tag $(IMAGE_NAME):$$tag $(IMAGE_NAME):$$branch; \
	done
	@latest=$(IMAGE_NAME):$(call tag,$(LATEST))
	@echo "Tagging $$latest as latest"
	docker tag $$latest $(IMAGE_NAME):latest

.PHONY: push
push:
	docker push -a $(IMAGE_NAME)
