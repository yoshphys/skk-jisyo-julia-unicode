.PHONY: all yaml build clean

all: build

yaml:
	julia generate_yaml.jl

build: yaml
	deno run --allow-read --allow-write build.ts

clean:
	rm -rf yaml dist
