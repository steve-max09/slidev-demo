FROM gknb/slidev-builder AS builder

COPY . /slidev

RUN npx slidev build slides.md --out /slidev/dist

FROM nginx:alpine

ARG IMAGE_CREATED
ARG IMAGE_URL
ARG IMAGE_SOURCE
ARG IMAGE_REVISION

LABEL org.opencontainers.image.created=${IMAGE_CREATED}
LABEL org.opencontainers.image.url="${IMAGE_URL}"
LABEL org.opencontainers.image.source="${IMAGE_SOURCE}"
LABEL org.opencontainers.image.revision=${IMAGE_REVISION}

COPY --from=builder /slidev/dist /usr/share/nginx/html