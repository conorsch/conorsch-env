#!/bin/bash
set -e
#set -u
set -o pipefail

# Look up location, for reference to relpaths
script_path="$(realpath "$0")"
script_dir="$(dirname "$script_path")"

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
    #tmp_venv="${script_dir}/venv"
    system_packages=""
    # Virtualenvs in Qubes have trouble discovering python-apt modules;
    if is_likely_qubes ; then
        system_packages="--system-site-packages"
    fi
    virtualenv --python python3 "$tmp_venv" "${system_packages}"
    source "${tmp_venv}/bin/activate"
}

function run_ansible() {
    mkdir -p "${script_dir}/.roles"
    ansible-galaxy install -r "${script_dir}/requirements.yml"
    ansible-playbook "${script_dir}/examples/localhost.yml"
}

printf "Checking if pip is installed... "
if ! is_installed pip3 ; then
    sudo apt install -y python3-pip
    printf "CHANGED.\n"
else
    printf "OK.\n"
fi

printf "Checking if pipenv is installed... "
export PATH=$PATH:$HOME/.local/bin
if ! is_installed pipenv ; then
    pip3 install --user pipenv
    printf "CHANGED.\n"
else
    printf "OK.\n"
fi


printf "Checking if ansible is installed... "
configure_venv
if ! is_installed ansible > /dev/null 2>&1 ; then
    printf "no, installing... "
    sudo apt-get install -y python3-apt -qq
    configure_venv
    pipenv --three install
    printf "CHANGED.\n"
else
    printf "OK.\n"
fi

run_ansible
