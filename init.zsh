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
}

######################################################################
#<
#
# Function: p6df::modules::docker::external::brew()
#
#>
######################################################################
p6df::modules::docker::external::brew() {

  brew install --cask docker
  brew install docker-compose
  brew install docker-credential-helper
  brew install docker-credential-helper-ecr
  brew install docker-gen
  brew install docker-ls
  brew install docker-slim
  brew install docker-squash
  brew install dockerize
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
}

######################################################################
#<
#
# Function: p6df::modules::docker::init()
#
#>
######################################################################
p6df::modules::docker::init() {

  p6df::modules::docker::prompt::init
}

######################################################################
#<
#
# Function: p6df::modules::docker::prompt::init()
#
#>
######################################################################
p6df::modules::docker::prompt::init() {

  p6df::core::prompt::line::add "p6df::modules::docker::prompt::line"
}

######################################################################
#<
#
# Function: p6df::modules::docker::prompt::line()
#
#>
######################################################################
p6df::modules::docker::prompt::line() {

  p6_docker_prompt_info
}

######################################################################
#<
#
# Function: str str = p6_docker_prompt_info()
#
#  Returns:
#	str - str
#
#  Environment:	 CMD RUN
#>
######################################################################
p6_docker_prompt_info() {

  local str
  if p6_file_exists "Dockerfile"; then
    local cmd=$(egrep '^CMD|^ENTRYPOINT' Dockerfile | head -1)
    if p6_string_blank "$cmd"; then
      cmd=$(grep '^RUN' Dockerfile | tail -1)
    fi
    str="docker:\t\t  $cmd"
    p6_return_str "$str"
  else
    p6_return_void
  fi
}

######################################################################
#<
#
# Function: p6_docker_dbash()
#
#>
######################################################################
p6_docker_dbash() {

  docker exec -it $(docker ps -aqf "name=$1") bash
}

######################################################################
#<
#
# Function: p6_docker_dzsh()
#
#>
######################################################################
p6_docker_dzsh() {

  docker exec -it $(docker ps -aqf "name=$1") zsh
}
