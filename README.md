# ansible-role-pgdeploy

Ansible role for deploy PostgreSQL scripts.

## Requirements

- PostgreSQL Client, version > 10
- Rsync

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    pgdeploy_src: ''

Source of sql scripts to be deployed (required).

    pgdeploy_id: "{{ pgdeploy_src | hash('md5') | regex_replace('(........).*', '\\1') }}"

Custom unique identifier, it will be used to generate unique path.

    pgdeploy_user: postgres
    pgdeploy_host: localhost
    pgdeploy_db: postgres
    pgdeploy_port: 5432

Database authentification settings.

    pgdeploy_entrypoint: 'deploy.sql'

Script file name to be deployed.

    pgdeploy_dest_dir: /srv/pgdeploy

Base directory, for scripts.

    pgdeploy_dest_proj_dir: "{{pgdeploy_dest_dir}}/{{pgdeploy_db}}/{{pgdeploy_id}}"

Scripts (specified in pgdeploy_src) will be synchronized into this remote directory.

    pgdeploy_vars: {}

Custom variables to be injected into psql variables.

## Dependencies

None.

## Example Playbook

- hosts: database
  become: yes
  vars:
    pgdeploy_src: '../../sql'
  roles:
    - ansible-role-pgdeploy

## License

MIT / BSD

## Author Information

Andrey Chalov
