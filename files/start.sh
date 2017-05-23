#!/usr/bin/env bash

set -e

case ${1} in
    start)
        echo "${@:2}"
        exec python -m rasa_nlu.server -c ./config.json "${@:2}"
        ;;
esac
