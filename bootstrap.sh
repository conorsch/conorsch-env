#!/bin/bash
set -e
#set -u
set -o pipefail


function is_installed() {
    hash "$1" > /dev/null 2>&1
}

function is_likely_qubes() {
    result=1
    if printenv | grep -q ^QUBES ; then
        result=0
    fi
    return "$result"
}

function configure_venv() {
    tmp_venv="$(mktemp -d)"
    system_packages=""
    # Virtualenvs in Qubes have trouble discovering python-apt modules;
    if is_likely_qubes ; then
        system_packages="--system-site-packages"
    fi
    virtualenv "$tmp_venv" "${system_packages}" --quiet
    source "${tmp_venv}/bin/activate"
}

function run_ansible() {
    mkdir -p .roles
    pipenv run ansible-galaxy install -r requirements.yml > /dev/null 2>&1
    pipenv run ansible-playbook examples/localhost.yml
}

printf "Checking if pip is installed... "
if ! is_installed pip ; then
    sudo apt install -y python-pip
    printf "CHANGED.\n"
else
    printf "OK.\n"
fi

printf "Checking if pipenv is installed... "
export PATH=$PATH:$HOME/.local/bin
if ! is_installed pipenv ; then
    pip install --user pipenv
    printf "CHANGED.\n"
else
    printf "OK.\n"
fi


printf "Checking if ansible is installed... "
if ! is_installed ansible > /dev/null 2>&1 ; then
    printf "no, installing... "
    configure_venv
    pipenv install > /dev/null 2>&1
    printf "CHANGED.\n"
    run_ansible
else
    printf "OK.\n"
fi

