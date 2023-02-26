FROM --platform=$BUILDPLATFORM tinygo/tinygo:0.27.0 AS build
WORKDIR /build
COPY go.mod go.sum ./
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    go mod download
COPY main.go .
RUN tinygo build -target=wasi -gc=leaking -no-debug -o main.wasm main.go

FROM scratch
COPY --from=build /build/main.wasm ./main.wasm
COPY spin.toml .
