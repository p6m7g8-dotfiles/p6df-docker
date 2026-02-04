# P6's POSIX.2: p6df-docker

## Table of Contents

- [Badges](#badges)
- [Summary](#summary)
- [Contributing](#contributing)
- [Code of Conduct](#code-of-conduct)
- [Usage](#usage)
  - [Functions](#functions)
- [Hierarchy](#hierarchy)
- [Author](#author)

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## Summary

TODO: Add a short summary of this module.

## Contributing

- [How to Contribute](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Functions

#### p6df-docker

##### p6df-docker/init.zsh

- `p6df::modules::docker::deps()`
- `p6df::modules::docker::external::brew()`
- `p6df::modules::docker::home::symlink()`
- `p6df::modules::docker::init(_module, dir)`
  - Args:
    - _module - 
    - dir - 
- `p6df::modules::docker::vscodes()`
- `p6df::modules::docker::vscodes::config()`
- `str str = p6df::modules::docker::prompt::mod()`

#### p6df-docker/lib

##### p6df-docker/lib/docker.sh

- `p6_docker_dbash()`
- `p6_docker_dzsh()`

## Hierarchy

```text
.
├── init.zsh
├── lib
│   └── docker.sh
├── README.md
└── share

3 directories, 3 files
```

## Author

Philip M. Gollucci <pgollucci@p6m7g8.com>
