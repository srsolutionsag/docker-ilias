IMAGE = sturai/ilias
BRANCHES = 5.1 5.2 5.3

build = \
    docker build --rm \
        -t $(IMAGE):$(1) \
        -t $(IMAGE):$(3) \
        -t $(IMAGE):$(3)-$(2) \
        $(1)/$(2)

.PHONY: build
build:
	for branch in $(BRANCHES); do \
		for variant in $$branch/*; do \
			variant=$$(basename $$variant); \
			version=$$(grep "ENV ILIAS_VERSION" $$branch/$$variant/Dockerfile \
				| awk -F "=" '{print $$2}'); \
			$(call build,$$branch,$$variant,$$version); \
		done; \
	done; \
	docker tag $(IMAGE):$$version $(IMAGE):latest
