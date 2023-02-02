ARG BASEDEV_VERSION=v0.20.4
ARG DEBIAN_VERSION=bullseye
ARG GO_VERSION=1.19
ARG GOMODIFYTAGS_VERSION=v1.16.0
ARG GOPLAY_VERSION=v1.0.0
ARG GOTESTS_VERSION=v1.6.0
ARG DLV_VERSION=v1.20.1
ARG MOCKERY_VERSION=v2.16.0
ARG GOMOCK_VERSION=v1.6.0
ARG MOCKGEN_VERSION=v1.6.0
ARG GOPLS_VERSION=v0.11.0
ARG GOLANGCILINT_VERSION=v1.50.1
ARG IMPL_VERSION=v1.1.0
ARG GOPKGS_VERSION=v2.1.2
ARG KUBECTL_VERSION=v1.26.0
ARG STERN_VERSION=v1.22.0
ARG KUBECTX_VERSION=v0.9.4
ARG KUBENS_VERSION=v0.9.4
ARG HELM_VERSION=v3.10.3


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
FROM kbuley/binpot:kubectl-${KUBECTL_VERSION} AS kubectl
FROM kbuley/binpot:stern-${STERN_VERSION} AS stern
FROM kbuley/binpot:kubectx-${KUBECTX_VERSION} AS kubectx
FROM kbuley/binpot:kubens-${KUBENS_VERSION} AS kubens
FROM kbuley/binpot:helm-${HELM_VERSION} AS helm

FROM kbuley/basedevcontainer:${BASEDEV_VERSION}-debian
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
    org.opencontainers.image.title="Go Dev container Debian" \
    org.opencontainers.image.description="Go development container for Visual Studio Code Remote Containers development"
# Install Debian packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends g++ wget && \
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

COPY --chmod=755 --from=gomodifytags /bin /go/bin/gomodifytags
COPY --chmod=755 --from=goplay  /bin /go/bin/goplay
COPY --chmod=755 --from=gotests /bin /go/bin/gotests
COPY --chmod=755 --from=dlv /bin /go/bin/dlv
COPY --chmod=755 --from=mockery /bin /go/bin/mockery
COPY --chmod=755 --from=gomock /bin /go/bin/gomock
COPY --chmod=755 --from=mockgen /bin /go/bin/mockgen
COPY --chmod=755 --from=gopls /bin /go/bin/gopls
COPY --chmod=755 --from=golangci-lint /bin /go/bin/golangci-lint
COPY --chmod=755 --from=impl /bin /go/bin/impl
COPY --chmod=755 --from=gopkgs /bin /go/bin/gopkgs

# Extra binary tools
COPY --chmod=755 --from=kubectl /bin /usr/local/bin/kubectl
COPY --chmod=755 --from=stern /bin /usr/local/bin/stern
COPY --chmod=755 --from=kubectx /bin /usr/local/bin/kubectx
COPY --chmod=755 --from=kubens /bin /usr/local/bin/kubens
COPY --chmod=755 --from=helm /bin /usr/local/bin/helm
