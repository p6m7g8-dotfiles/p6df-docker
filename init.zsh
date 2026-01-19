# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::docker::deps()
#
#>
######################################################################
p6df::modules::docker::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6df-zsh
    ohmyzsh/ohmyzsh:plugins/docker
    ohmyzsh/ohmyzsh:plugins/docker-compose
    akarzim/zsh-docker-aliases
  )
}

######################################################################
#<
#
# Function: p6df::modules::docker::vscodes()
#
#>
######################################################################
p6df::modules::docker::vscodes() {

  # docker
  code --install-extension ms-azuretools.vscode-docker
  code --install-extension ms-vscode-remote.remote-containers

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::docker::external::brew()
#
#>
######################################################################
p6df::modules::docker::external::brew() {

  p6df::modules::homebrew::cli::brew::install --cask docker
  p6df::modules::homebrew::cli::brew::install docker-compose
  p6df::modules::homebrew::cli::brew::install docker-credential-helper
  p6df::modules::homebrew::cli::brew::install docker-credential-helper-ecr
  p6df::modules::homebrew::cli::brew::install docker-gen
  p6df::modules::homebrew::cli::brew::install docker-ls
  p6df::modules::homebrew::cli::brew::install docker-slim
  p6df::modules::homebrew::cli::brew::install docker-squash
  p6df::modules::homebrew::cli::brew::install dockerize

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::docker::home::symlink()
#
#  Environment:	 HOMEBREW_PREFIX
#>
######################################################################
p6df::modules::docker::home::symlink() {

  # Compose is now a Docker Plugin and needs to be symlinked to be found
  p6_dir_mk ".docker/cli-plugins"
  p6_file_symlink "$HOMEBREW_PREFIX/opt/docker-compose/bin/docker-compose" ".docker/cli-plugins/docker-compose"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::docker::init(_module, dir)
#
#  Args:
#	_module -
#	dir -
#
#>
######################################################################
p6df::modules::docker::init() {
  local _module="$1"
  local dir="$2"

  p6_bootstrap "$dir"

  p6_return_void
}

######################################################################
#<
#
# Function: str str = p6df::modules::docker::prompt::mod()
#
#  Returns:
#	str - str
#
#  Environment:	 CMD RUN
#>
######################################################################
p6df::modules::docker::prompt::mod() {

  local str
  if p6_file_exists "Dockerfile"; then
    local cmd=$(grep -E '^CMD|^ENTRYPOINT' Dockerfile | head -1)
    if p6_string_blank "$cmd"; then
      cmd=$(grep '^RUN' Dockerfile | tail -1)
    fi
    str="docker:\t\t  $cmd"
  fi

  p6_return_str "$str"
}
