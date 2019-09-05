#!/usr/bin/env bash
##
## Copyright (c) 2019 ManuelCH.
##
## This file is part of testcpp 
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
    echo "Usage: $0 <cpp_file> [-v <version_number>] [-d]" 1>&2; 
    exit 1; 
}

if [[ $# -lt 1 ]]; then
    echo "Not enough arguments provided"
    usage
fi

CPP_FILE=$1

if [[ "${CPP_FILE: -4}" != ".cpp" ]]; then
    echo "Not cpp file provided (extension .cpp)"
    usage
else
    if [[ ! -f "$CPP_FILE" ]]; then
        echo "$CPP_FILE does not exist"
    fi
fi

FILENAME=${CPP_FILE%%.cpp}

shift

VERSION=""
DEBUG=""

while getopts 'v:d' OPTION; do
  case $OPTION in

    v)
        VERSION="-std=c++$OPTARG"
        if [[ "$VERSION" == "-d" ]] ; then
            usage
        fi
        ;;

    d)
        DEBUG="-DDEBUG"
        ;;

    ?)
        usage
        ;;
  esac
done
shift $((OPTIND-1))

if [[ -n "$VERSION" ]] && [[ -n "$DEBUG" ]]; then
    g++ "$CPP_FILE" -o "$FILENAME.out" "$VERSION" "$DEBUG"
elif [[ -n "$VERSION" ]]; then
    g++ "$CPP_FILE" -o "$FILENAME.out" "$VERSION"
elif [[ -n "$DEBUG" ]]; then
    g++ "$CPP_FILE" -o "$FILENAME.out" "$DEBUG"
else
    g++ "$CPP_FILE" -o "$FILENAME.out"
fi

status=$?

if [[ "$status" -ne 0 ]]; then
    exit "$status"
   
fi

./"$FILENAME.out"

status=$?

if [[ "$status" -ne 0 ]]; then
    exit "$status"
fi

rm -f "$FILENAME.out"

exit $?