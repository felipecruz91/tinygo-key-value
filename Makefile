build:
	docker buildx build \
	--platform=wasi/wasm \
	-t felipecruz/tinygo-key-value . \
	--load

run:
	docker run \
	--runtime=io.containerd.wasmedge.v1 \
	--platform=wasi/wasm \
	felipecruz/tinygo-key-value

push:
	docker buildx build \
	--push \
	--provenance=false \
	--platform=wasi/wasm \
	-t felipecruz/tinygo-key-value .
