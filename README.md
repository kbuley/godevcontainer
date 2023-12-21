# Go Dev Container

**Ultimate Go development container for Visual Studio Code**

[![godevcontainer](https://github.com/kbuley/godevcontainer/raw/main/title.png)](https://hub.docker.com/r/kbuley/godevcontainer)

[![Alpine](https://github.com/kbuley/godevcontainer/actions/workflows/alpine.yml/badge.svg)](https://github.com/kbuley/godevcontainer/actions/workflows/alpine.yml)
[![Debian](https://github.com/kbuley/godevcontainer/actions/workflows/debian.yml/badge.svg)](https://github.com/kbuley/godevcontainer/actions/workflows/debian.yml)
[![Ubuntu](https://github.com/kbuley/godevcontainer/actions/workflows/ubuntu.yml/badge.svg)](https://github.com/kbuley/godevcontainer/actions/workflows/ubuntu.yml)

[![dockeri.co](https://dockeri.co/image/kbuley/godevcontainer)](https://hub.docker.com/r/kbuley/godevcontainer)

![Last Docker tag](https://img.shields.io/docker/v/kbuley/godevcontainer?sort=semver&label=Last%20Docker%20tag)
[![Latest size](https://img.shields.io/docker/image-size/kbuley/godevcontainer/latest?label=Latest%20image)](https://hub.docker.com/r/kbuley/godevcontainer/tags)

![Last release](https://img.shields.io/github/release/kbuley/godevcontainer?label=Last%20release)
[![Last release size](https://img.shields.io/docker/image-size/kbuley/godevcontainer?sort=semver&label=Last%20released%20image)](https://hub.docker.com/r/kbuley/godevcontainer/tags?page=1&ordering=last_updated)
![GitHub last release date](https://img.shields.io/github/release-date/kbuley/godevcontainer?label=Last%20release%20date)
![Commits since release](https://img.shields.io/github/commits-since/kbuley/godevcontainer/latest?sort=semver)

[![GitHub last commit](https://img.shields.io/github/last-commit/kbuley/godevcontainer.svg)](https://github.com/kbuley/godevcontainer/commits/main)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/y/kbuley/godevcontainer.svg)](https://github.com/kbuley/godevcontainer/graphs/contributors)
[![GitHub closed PRs](https://img.shields.io/github/issues-pr-closed/kbuley/godevcontainer.svg)](https://github.com/kbuley/godevcontainer/pulls?q=is%3Apr+is%3Aclosed)
[![GitHub issues](https://img.shields.io/github/issues/kbuley/godevcontainer.svg)](https://github.com/kbuley/godevcontainer/issues)
[![GitHub closed issues](https://img.shields.io/github/issues-closed/kbuley/godevcontainer.svg)](https://github.com/kbuley/godevcontainer/issues?q=is%3Aissue+is%3Aclosed)

[![Lines of code](https://img.shields.io/tokei/lines/github/kbuley/godevcontainer)](https://github.com/kbuley/godevcontainer)
![Code size](https://img.shields.io/github/languages/code-size/kbuley/godevcontainer)
![GitHub repo size](https://img.shields.io/github/repo-size/kbuley/godevcontainer)

![Visitors count](https://visitor-badge.laobi.icu/badge?page_id=godevcontainer.readme)

## Features

- Compatible with `amd64`, and `arm64` CPUs
- `kbuley/godevcontainer:alpine` and `kbuley/godevcontainer`
  - Based on Alpine 3.19
- `kbuley/godevcontainer:debian`
  - Based on Debian Bookworm Slim
- `kbuley/godevcontainer:ubuntu`
  - Based on Ubuntu LTS
- Based on [kbuley/basedevcontainer](https://github.com/kbuley/basedevcontainer)
  - Based on either Alpine, Debian, or Ubuntu
  - Minimal custom terminal and packages
  - See more [features](https://github.com/kbuley/basedevcontainer#features)
- Go 1.21.5 code obtained from the latest tagged Golang Docker image
- Go tooling [integrating with VS code](https://github.com/Microsoft/vscode-go/wiki/Go-tools-that-the-Go-extension-depends-on), all cross built statically from source at the [binpot](https://github.com/kbuley/binpot):
  - [Google's Go language server gopls](https://github.com/golang/tools/tree/master/gopls)
  - [golangci-lint](https://github.com/golangci/golangci-lint), includes golint and other linters
  - [dlv](https://github.com/go-delve/delve/cmd/dlv) ⚠️ only works on `amd64` and `arm64`
  - [gomodifytags](https://github.com/fatih/gomodifytags)
  - [goplay](https://github.com/haya14busa/goplay)
  - [impl](https://github.com/josharian/impl)
  - [gotype-live](https://github.com/tylerb/gotype-live)
  - [gotests](https://github.com/cweill/gotests)
  - [gopkgs v2](https://github.com/uudashr/gopkgs/tree/master/v2)
- Terminal Go tools
  - [mockgen](https://github.com/golang/mock) to generate mocks
  - [mockery](https://github.com/vektra/mockery) to generate mocks for testify/mock
- Cross platform
  - Easily bind mount your SSH keys to use with **git**
  - Manage your host Docker from within the dev container, more details at [kbuley/basedevcontainer](https://github.com/kbuley/basedevcontainer#features)
- Extensible with docker-compose.yml

## Requirements

- [Docker](https://www.docker.com/products/docker-desktop) installed and running
  - If you don't use Linux or Windows with WSL, share the directory `~/.ssh` and the directory of your project with Docker Desktop
- [Docker Compose](https://docs.docker.com/compose/install/) installed
- [VS code](https://code.visualstudio.com/download) installed
- [VS code remote containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed

## Setup for a project

1. Setup your configuration files

   - With style 💯

     ```sh
     docker run -it --rm -v "/yourrepopath:/repository" kbuley/devtainr:v0.2.0 -dev go -path /repository -name projectname
     ```

     Or use the [built binary](https://github.com/kbuley/devtainr#binary)

   - Or manually: download this repository and put the [.devcontainer](.devcontainer) directory in your project.

1. If you have a _.vscode/settings.json_, eventually move the settings to _.devcontainer/devcontainer.json_ in the `"settings"` section as _.vscode/settings.json_ take precedence over the settings defined in _.devcontainer/devcontainer.json_.
1. Open the command palette in Visual Studio Code (CTRL+SHIFT+P) and select `Remote-Containers: Open Folder in Container...` and choose your project directory

## Customization

See the [.devcontainer/README.md](.devcontainer/README.md) document in your repository.

## License

This repository is under an [MIT license](https://github.com/kbuley/godevcontainer/main/LICENSE) unless indicated otherwise.
