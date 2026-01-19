# shellcheck shell=bash
######################################################################
#<
#
# Function: p6_docker_dbash()
#
#>
######################################################################
p6_docker_dbash() {

  # shellcheck disable=2046
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

  # shellcheck disable=2046
  docker exec -it $(docker ps -aqf "name=$1") zsh
}
