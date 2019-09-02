#!/bin/bash

echo "[xApp] (Go Buffalo) Generation Language v1.2 by ATVG-Studios"

SCRIPT=""
FLAGS=""
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

    _flags "no-git" && GENERATOR_NEW="$GENERATOR_NEW --vcs none"
}

function _flags() {
     _contains "$FLAGS" "--flag=$1" && return 0 || return 1
}

function _contains() {
    [[ $1 =~ (^|[[:space:]])$2($|[[:space:]]) ]] && return 0 || return 1
}

function _git_commit() {
    _flags "no-git" && return

    command -v git >/dev/null 2>&1 || { echo "Cannot find git! Please install Git or use 'set_generator <name> --flag=no-git'"; exit 1; }

    cd $APP

    echo "[xApp] Commiting to Git (disable by adding '--flag=no-git' to 'set_generator <name')"
    git add -A;
    git commit -m "xApp: Finished automated generation";
}

function generator() {
    echo "[xApp] Running $GENERATOR"
    echo ">> $@"
    $GENERATOR $@
}

function set_generator() {
    GENERATOR="$1"

    for flag in "${@:2}"; do
        FLAGS="$FLAGS $flag"
    done

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

        rel_flags
    fi
}

function add_flag() {
    _flags $1 && return

    FLAGS="$FLAGS --flag=$1"
}

function rel_flags() {
    ARGS=""
    ACTION_ARGS=""


    if [ "$GENERATOR" = "buffalo" ]; then
        _flags "no-templates" && {
            ARGS="$ARGS --skip-templates"
            ACTION_ARGS="$ACTION_ARGS --skip-template"
        }

        _flags "no-migrations" && {
            ARGS="$ARGS --skip-migration"
        }
    fi
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

function end_generator() {
    echo "[xApp] Generation Script '$SCRIPT' ended."
    cd ..

    echo "[xApp] Copying '$SCRIPT' to '$APP'"
    cp $SCRIPT $APP

    _git_commit
}

if [ "$1" = "" ]; then
    echo "[xApp] Please specify atleast one .xapp definition"
else
    for xapp in "$@"; do
        SCRIPT="$1"
        source $1
    done
fi

echo "[xApp] Finished."
