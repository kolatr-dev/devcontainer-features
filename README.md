# Dev Container Features: Kolatr Style

> This repo is bootstrapped from the [Devcontainers Feature Starter](https://github.com/devcontainers/feature-starter).

## Features

* [aws](./src/aws/README.md)
* [common](./src/common/README.md)
* [eza](./src/eza/README.md)
* [mailpit](./src/mailpit/README.md)
* [shell-history](./src/shell-history/README.md)
* [shell-message](./src/shell-message/README.md)
* [starship](./src/starship/README.md)
* [tailscale](./src/tailscale/README.md)

## Updates

If you add features to this repo, to make them avaialble to downstream devcontainers you need to run the [release workflow](https://github.com/kolatr-dev/devcontainer-features/actions/workflows/release.yaml) manually.

## Usage 

```sh
devcontainer features test --base-image ubuntu:jammy
```
