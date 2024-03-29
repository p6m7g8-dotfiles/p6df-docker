# shellcheck shell=bash
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
