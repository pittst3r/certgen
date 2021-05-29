#!/bin/sh
set -e

source /usr/lib/certgen/commands.sh

cmd=$1
shift

ttl=0
mode=0600
owner=0:0

for opt in "$@"
do
  case $opt in
    --ttl=*)
      ttl="${opt#*=}"
      shift
      ;;
    --ttl)
      ttl=$2
      shift
      shift
      ;;
    --mode=*)
      mode="${opt#*=}"
      shift
      ;;
    --mode)
      mode=$2
      shift
      shift
      ;;
    --owner=*)
      owner="${opt#*=}"
      shift
      ;;
    --owner)
      owner=$2
      shift
      shift
      ;;
  esac
done

ca_name=$1
leaf_name=$2

case $cmd in
  -h|--help)
    cat /usr/lib/certgen/usage.txt
    ;;
  -v|--version)
    cat /usr/lib/certgen/VERSION
    ;;
  ca)
    if [ ! $ttl -o $ttl -lt 1 ]
    then
      ttl=3650
    fi

    create_ca
    ;;
  leaf)
    if [ ! $ttl -o $ttl -lt 1 ]
    then
      ttl=30
    fi
    create_leaf
    ;;
  *)
    usage
    ;;
esac
