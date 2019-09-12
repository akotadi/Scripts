#!/usr/bin/env bash
##
## Copyright (c) 2019 ManuelCH.
##
## This file is part of testvhdl 
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
    echo "Usage: $0 <vhdl_file> [-s <test_bench_vhdl_file]" 1>&2; 
    exit 1; 
}

clean() {
    rm -f "$TB_FILENAME" "FILENAME" *.cf *.o *.vcd
    exit $?
}

if [[ $# -lt 1 ]]; then
    echo "Not enough arguments provided"
    usage
fi

VHDL_FILE=$1

if [[ "${VHDL_FILE: -4}" != ".vhd" ]]; then
    echo "Not vhd file provided (extension .vhd)"
    usage
else
    if [[ ! -f "$VHDL_FILE" ]]; then
        echo "$VHDL_FILE does not exist"
    fi
fi

FILENAME=${VHDL_FILE%%.vhd}

shift

TB_VHDL_FILE=""
TB_FILENAME=""

while getopts 's:' OPTION; do
  case $OPTION in

    s)
        TB_VHDL_FILE="$OPTARG"
        if [[ "${TB_VHDL_FILE: -4}" != ".vhd" ]]; then
            echo "Not vhd file provided for test bench (extension .vhd)"
            usage
        else
            if [[ ! -f "$TB_VHDL_FILE" ]]; then
                echo "$TB_VHDL_FILE does not exist"
            fi
        fi
        TB_FILENAME=${TB_VHDL_FILE%%.vhd}
        ;;

    ?)
        usage
        ;;
  esac
done
shift $((OPTIND-1))

ghdl -a "$VHDL_FILE" 
status=$?
if [[ "$status" -ne 0 ]]; then
    clean
    exit "$status"
fi

ghdl -e "$FILENAME"
status=$?
if [[ "$status" -ne 0 ]]; then
    clean
    exit "$status"
fi

ghdl -r "$FILENAME"
status=$?
if [[ "$status" -ne 0 ]]; then
    clean
    exit "$status"
fi

if [[ -n "$TB_VHDL_FILE" ]]; then
    ghdl -a "$TB_VHDL_FILE"
    status=$?
    if [[ "$status" -ne 0 ]]; then
        clean
        exit "$status"
    fi

    ghdl -e "$TB_FILENAME"
    status=$?
    if [[ "$status" -ne 0 ]]; then
        clean
        exit "$status"
    fi

    ghdl -r "$TB_FILENAME" --vcd="$TB_FILENAME.vcd"
    status=$?
    if [[ "$status" -ne 0 ]]; then
        clean
        exit "$status"
    fi

    gtkwave "$TB_FILENAME.vcd" 
    status=$?
    if [[ "$status" -ne 0 ]]; then
        clean
        exit "$status"
    fi
fi

clean
