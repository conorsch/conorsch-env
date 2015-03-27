conorsch-env ansible role
=========
[![Build Status](https://travis-ci.org/conorsch/conorsch-env.svg?branch=master)](https://travis-ci.org/conorsch/conorsch-env)

Ansible role for configuring user environment how I like it. Useful 
for bootstrapping new machines. Installs common base packages
and configures dotfiles via [homeshick].

Requirements
------------

Assumes Ubuntu as OS.

Role Variables
--------------

Available variables are listed below, along with default values (see `defaults/main.yml`):

    username: conor
The username for environment configuration. User-level calls will be sudoized to this username.

    git_directory: "~{{username}}/gits"

Default directory for storing git projects. Does not include homeshick projects.

    github_username: conorsch

Username on github.com. Used for pulling SSH keys (see below) and dotfiles URL.

    github_key_url: https://github.com/{{github_username}}.keys
    dotfiles_repo: git://github.com/{{github_username}}/dotfiles.git

Default GitHub URLs. 

    default_shell: /bin/bash

Default shell. 

    include_graphical_packages: false

Includes GUI applications such as firefox. 

    DEBUG: false

Makes some Ansible tasks noisier, for debugging.

Dependencies
------------

* [gcporras.virtualenvwrapper]

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: my-machines
      include_vars: vars/main.yml
      roles:
        - { role: conorsch.conorsch-env }

*Inside `vars/main.yml`*:

    username: yourusername
    github_username: yourgithubusername

License
-------

MIT

[homeshick]:https://github.com/andsens/homeshick
[gcporras.virtualenvwrapper]:https://galaxy.ansible.com/list#/roles/1187
