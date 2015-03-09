conorsch-env ansible role
=========
[![Build Status](https://travis-ci.org/conorsch/conorsch-env.svg?branch=master)](https://travis-ci.org/conorsch/conorsch-env)

Ansible role for configuring user environment how I like it. Useful 
for bootstrapping new machines. Installs common base packages
and configures dotfiles via [[homeshick]].

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

    dotfiles_repo: git://github.com/ronocdh/dotfiles.git

Git repo URL for cloning homeshick dotfiles.

Dependencies
------------

None.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: my-machines
      include_vars: vars/main.yml
      roles:
        - { role: conorsch.conorsch-env }

*Inside `vars/main.yml`*:

    username: yourusername
    dotfiles_repo: git://github.com/yourusername/dotfiles.git

License
-------

MIT

[homeshick]:https://github.com/andsens/homeshick
