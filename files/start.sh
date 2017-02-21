#!/usr/bin/env bash

set -e

case ${1} in
    start)
        exec python -m rasa_nlu.server -c ./config.json
        ;;
esac