#!/usr/bin/env bash
##
## Copyright (c) 2019 ManuelCH.
##
## This file is part of ubuntu_icpc_config 
## (see https://github.com/akotadi/Scripts).
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program. If not, see <http://www.gnu.org/licenses/>.
##

set -o errexit # (a.k.a. set -e)
set -o nounset # (a.k.a. set -u)
set -o pipefail
# set -o xtrace # (a.k.a set -x) useful to debug

# Set magic variables for current file, directory, os, etc.
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)"


usage() { 
    echo "Usage: $0" 1>&2; 
    exit 1; 
}

check_installation() { 
    status=$?
    if [[ "$status" -ne 0 ]]; then
        exit "$status"
    fi
}

DEBUG=""

while getopts 'd' OPTION; do
  case $OPTION in
    d)
        DEBUG="ON"
        ;;

    ?)
        usage
        ;;
  esac
done
shift $((OPTIND-1))

# Fixing the hour problem with Windows
timedatectl set-local-rtc 1 --adjust-system-clock
check_installation

if [[ -n "$DEBUG" ]]; then
    timedatectlexit
    check_installation
fi

##                          ##
##   INITIAL CONFIGURATION  ##
##                          ##

# Setting up the system with update and clean
echo "http://mx.archive.ubuntu.com/ubuntu/" | sudo tee -a /etc/apt/sources.list
check_installation

sudo apt update
check_installation

sudo apt -y upgrade
check_installation

sudo apt -y autoclean
check_installation

sudo apt -y autoremove
check_installation



##                              ##
##   LANGUAGES CONFIGURATION    ##
##                              ##

# Installing git
sudo apt -y install git-core
check_installation

# Installing gcc
sudo apt -y install gcc
check_installation

# Installing g++
sudo apt -y install g++
check_installation

# Installing python
sudo apt -y install python
check_installation

# Installing python3
sudo apt -y install python3
check_installation

# Installing java
sudo apt -y install openjdk-11-jdk
check_installation



##                            ##
##   EDITORS CONFIGURATION    ##
##                            ##

# Vim
sudo apt -y install vim
check_installation

# Sublime Text 3
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
check_installation

sudo apt -y upgrade
check_installation

sudo apt -y install sublime-text
check_installation

# AStyle Formatter Plugin
mkdir ~/.config/sublime-text-3/Packages/
(cd ~/.config/sublime-text-3/Packages/ && git clone git://github.com/timonwong/SublimeAStyleFormatter.git)
check_installation
