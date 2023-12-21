ARG BASEDEV_VERSION=v0.20.11
ARG DEBIAN_VERSION=bookworm
ARG GO_VERSION=1.21.5
ARG GOMODIFYTAGS_VERSION=v1.16.0
ARG GOPLAY_VERSION=v1.0.0
ARG GOTESTS_VERSION=v1.6.0
ARG DLV_VERSION=v1.21.2
ARG MOCKERY_VERSION=v2.38.0
ARG GOMOCK_VERSION=v1.6.0
ARG MOCKGEN_VERSION=v1.6.0
ARG GOPLS_VERSION=v0.14.2
ARG GOLANGCILINT_VERSION=v1.55.2
ARG IMPL_VERSION=v1.2.0
ARG GOPKGS_VERSION=v2.1.2
ARG GOCOV_VERSION=v1.1.0
ARG GOCOVHTML_VERSION=v1.4.0


FROM golang:${GO_VERSION}-${DEBIAN_VERSION} AS go
FROM kbuley/binpot:gomodifytags-${GOMODIFYTAGS_VERSION} AS gomodifytags
FROM kbuley/binpot:goplay-${GOPLAY_VERSION} AS goplay
FROM kbuley/binpot:gotests-${GOTESTS_VERSION} AS gotests
FROM kbuley/binpot:dlv-${DLV_VERSION} AS dlv
FROM kbuley/binpot:mockery-${MOCKERY_VERSION} AS mockery
FROM kbuley/binpot:gomock-${GOMOCK_VERSION} AS gomock
FROM kbuley/binpot:mockgen-${MOCKGEN_VERSION} AS mockgen
FROM kbuley/binpot:gopls-${GOPLS_VERSION} AS gopls
FROM kbuley/binpot:golangci-lint-${GOLANGCILINT_VERSION} AS golangci-lint
FROM kbuley/binpot:impl-${IMPL_VERSION} AS impl
FROM kbuley/binpot:gopkgs-${GOPKGS_VERSION} AS gopkgs
FROM kbuley/binpot:gocov-${GOCOV_VERSION} AS gocov
FROM kbuley/binpot:gocov-html-${GOCOVHTML_VERSION} AS gocov-html

FROM kbuley/basedevcontainer:${BASEDEV_VERSION}-ubuntu
ARG CREATED
ARG COMMIT
ARG VERSION=local
ARG USERNAME=vscode
LABEL \
  org.opencontainers.image.authors="kevin@buley.org" \
  org.opencontainers.image.created=$CREATED \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$COMMIT \
  org.opencontainers.image.url="https://github.com/kbuley/godevcontainer" \
  org.opencontainers.image.documentation="https://github.com/kbuley/godevcontainer" \
  org.opencontainers.image.source="https://github.com/kbuley/godevcontainer" \
  org.opencontainers.image.title="Go Dev container Ubuntu" \
  org.opencontainers.image.description="Go development container for Visual Studio Code Remote Containers development"
USER root

#hadolint ignore=DL3008
RUN apt-get update && \
  apt-get install -y --no-install-recommends g++ wget && \
  mkdir /go && chown ${USERNAME} /go && \
  apt-get autoremove -y && \
  apt-get clean -y && \
  rm -r /var/cache/* /var/lib/apt/lists/*

USER $USERNAME
COPY --chmod=755 --from=go /usr/local/go /usr/local/go
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH \
  CGO_ENABLED=0 \
  GO111MODULE=on
WORKDIR $GOPATH

# Shell setup
COPY --chown=${USERNAME}:${USERNAME} shell/.zshrc-specific shell/.welcome.sh /${USERNAME}/

COPY --chmod=755 --chown=${USERNAME}:${USERNAME} --from=gomodifytags /bin /go/bin/gomodifytags
COPY --chmod=755 --chown=${USERNAME}:${USERNAME} --from=goplay  /bin /go/bin/goplay
COPY --chmod=755 --chown=${USERNAME}:${USERNAME} --from=gotests /bin /go/bin/gotests
COPY --chmod=755 --chown=${USERNAME}:${USERNAME} --from=dlv /bin /go/bin/dlv
COPY --chmod=755 --chown=${USERNAME}:${USERNAME} --from=mockery /bin /go/bin/mockery
COPY --chmod=755 --chown=${USERNAME}:${USERNAME} --from=gomock /bin /go/bin/gomock
COPY --chmod=755 --chown=${USERNAME}:${USERNAME} --from=mockgen /bin /go/bin/mockgen
COPY --chmod=755 --chown=${USERNAME}:${USERNAME} --from=gopls /bin /go/bin/gopls
COPY --chmod=755 --chown=${USERNAME}:${USERNAME} --from=golangci-lint /bin /go/bin/golangci-lint
COPY --chmod=755 --chown=${USERNAME}:${USERNAME} --from=impl /bin /go/bin/impl
COPY --chmod=755 --chown=${USERNAME}:${USERNAME} --from=gopkgs /bin /go/bin/gopkgs
COPY --chmod=755 --chown=${USERNAME}:${USERNAME} --from=gocov /bin /go/bin/gocov
COPY --chmod=755 --chown=${USERNAME}:${USERNAME} --from=gocov-html /bin /go/bin/gocov-html

