FROM alpine:3.23.3 AS lovely
RUN apk add --no-cache --virtual .build-deps \
    gcc \
	g++ \
    make \
	cargo \
	rust \
	git \
	cmake

ARG VERSION=v0.9.0

RUN git clone https://github.com/Ethangreen-dev/lovely-injector --branch "$VERSION" --depth 1 --recurse-submodules /lovely-injector 

WORKDIR /lovely-injector

RUN cargo build --package lovely-unix --release


FROM alpine:3.23.3
RUN apk add love xvfb xvfb-run mesa-dri-gallium mesa-egl mesa-gles

RUN addgroup -S gamer && adduser -S gamer -G gamer --shell /bin/sh

COPY --from=lovely /lovely-injector/target/release/liblovely.so /balatro/liblovely.so

COPY /rungame.sh /balatro/rungame.sh

ENTRYPOINT ["/bin/ash", "-c", "/balatro/rungame.sh"]
