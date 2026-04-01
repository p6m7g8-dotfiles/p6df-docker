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
    wrsmith108/claude-code-docker-skill
    rohitg00/awesome-claude-code-toolkit:plugins/docker-helper
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
  p6df::modules::vscode::extension::install ms-azuretools.vscode-docker
  p6df::modules::vscode::extension::install ms-vscode-remote.remote-containers

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::docker::vscodes::config()
#
#>
######################################################################
p6df::modules::docker::vscodes::config() {

  cat <<'EOF'
  "[dockerfile]": {
    "editor.defaultFormatter": "ms-azuretools.vscode-container"
  },
  "[dockercompose]": {
    "editor.defaultFormatter": "redhat.vscode-yaml"
  }
EOF

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::docker::external::brews()
#
#>
######################################################################
p6df::modules::docker::external::brews() {

  p6df::core::homebrew::cli::brew::install --cask docker
  p6df::core::homebrew::cli::brew::install docker-compose
  p6df::core::homebrew::cli::brew::install docker-credential-helper
  p6df::core::homebrew::cli::brew::install docker-credential-helper-ecr
  p6df::core::homebrew::cli::brew::install docker-gen
  p6df::core::homebrew::cli::brew::install docker-ls
  p6df::core::homebrew::cli::brew::install docker-slim
  p6df::core::homebrew::cli::brew::install docker-squash
  p6df::core::homebrew::cli::brew::install dockerize

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::docker::home::symlinks()
#
#  Environment:	 HOME HOMEBREW_PREFIX P6_DFZ_SRC_DIR
#>
######################################################################
p6df::modules::docker::home::symlinks() {

  # Compose is now a Docker Plugin and needs to be symlinked to be found
  p6_dir_mk "$HOME/.docker/cli-plugins"
  p6_file_symlink "$HOMEBREW_PREFIX/opt/docker-compose/bin/docker-compose" "$HOME/.docker/cli-plugins/docker-compose"

  p6_file_symlink "$P6_DFZ_SRC_DIR/wrsmith108/claude-code-docker-skill/skills/docker"                                        "$HOME/.claude/skills/docker"
  p6_file_symlink "$P6_DFZ_SRC_DIR/akin-ozer/cc-devops-skills/devops-skills-plugin/skills/dockerfile-generator"              "$HOME/.claude/skills/dockerfile-generator"
  p6_file_symlink "$P6_DFZ_SRC_DIR/akin-ozer/cc-devops-skills/devops-skills-plugin/skills/dockerfile-validator"              "$HOME/.claude/skills/dockerfile-validator"

  p6_return_void
}

######################################################################
#<
#
# Function: str str = p6df::modules::docker::prompt::context()
#
#  Returns:
#	str - str
#
#>
######################################################################
p6df::modules::docker::prompt::context() {

  local str
  if p6_file_exists "Dockerfile"; then
    local cmd=$(p6_filter_row_select_regex '^CMD|^ENTRYPOINT' < Dockerfile | p6_filter_row_first 1)
    if p6_string_blank "$cmd"; then
      cmd=$(p6_filter_row_select_regex '^RUN' < Dockerfile | p6_filter_row_last 1)
    fi
    str="$(p6_string_space_pad "docker:" 16)$cmd"
  fi

  p6_return_str "$str"
}
