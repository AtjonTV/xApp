#!/bin/bash

echo "[xApp] (Go Buffalo) Generation Language v1.0 by ATVG-Studios"

APP=""
ARGS=""
ACTION_ARGS=""

GENERATOR="echo"
GENERATOR_NEW=""
GENERATOR_RESOURCE=""
GENERATOR_ACTION=""
GENERATOR_MODEL=""
GENERATOR_MAILER=""
GENERATOR_TASK=""

function _buffalo_new() {
    if [ "$2" = "app" ]
    then
        GENERATOR_NEW="new $1 --ci-provider $3 --db-type $4"
        ARGS=""
        ACTION_ARGS=""
    else
        GENERATOR_NEW="new $1 --$2 --ci-provider $3 --db-type $4"
    fi
}

function generator() {
    echo "[xApp] Running $GENERATOR"
    echo ">> $@"
    $GENERATOR $@
}

function set_generator() {
    GENERATOR="$1"

    if [ "$GENERATOR" = "buffalo" ]
    then
        command -v buffalo >/dev/null 2>&1 || { echo >&2 "In order to use buffalo, buffalo is required! Cannot find buffalo in PATH! Aborting."; exit 1; }
        command -v buffalo-pop >/dev/null 2>&1 || { echo >&2 "In order to use buffalo, buffalo-pop is required! Cannot find buffalo-pop in PATH!  Aborting."; exit 1; }

        GENERATOR_NEW=""
        GENERATOR_RESOURCE="g r"
        GENERATOR_ACTION="g a"
        GENERATOR_MODEL="db g m"
        GENERATOR_MAILER="g mailer"
        GENERATOR_TASK="g t"
	ARGS="--skip-templates"
	ACTION_ARGS="--skip-template"
    fi
}

function end_generator() {
    git commit -m "xApp: Finished automated generation"
}

function gen_project() {
    if [ "$GENERATOR" = "buffalo" ]; then
        _buffalo_new $@
    fi

    generator $GENERATOR_NEW

    APP="$1"

    cd $1
}

function gen_resource() {
    echo "[xApp] Generate Resource: $1"
    generator $GENERATOR_RESOURCE $@ $ARGS
    sleep 2
}

function gen_model() {
    echo "[xApp] Generate Model: $1"
    generator $GENERATOR_MODEL $@
    sleep 2
}

function gen_mailer() {
    echo "[xApp] Generate Mailer: $1"
    generator $GENERATOR_MAILER $@
    sleep 2
}

function gen_action() {
    echo "[xApp] Generate Action: $1"
    generator $GENERATOR_ACTION $1 $@ $ACTION_ARGS
    sleep 2
}

function gen_task() {
    echo "[xApp] Generate Task: $1"
    generator $GENERATOR_TASK $@
    sleep 2
}

function del_project() {
    if [ -e $1 ]; then
        rm -rf $1
    fi
}

source $@

echo "[xApp] Generation Script '$1' ended."
cd ..

echo "[xApp] Copying '$1' to '$APP'"
cp $1 $APP

echo "[xApp] Finished."
