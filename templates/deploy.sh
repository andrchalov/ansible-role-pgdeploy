#!/bin/bash

{% if pgdeploy_password is defined %}export PGPASSWORD="{{ pgdeploy_password }}" {% endif %}

echo '
\set ON_ERROR_STOP
BEGIN;
{% for var in pgdeploy_vars %}
\set {{var}} `cat {{pgdeploy_vars_dir}}/{{var}}`
{% endfor %}
\ir {{ pgdeploy_entrypoint }}
COMMIT;
' |
psql -U {{pgdeploy_user}} -h {{pgdeploy_host}} -d {{ pgdeploy_db }} -p {{ pgdeploy_port }} -v ON_ERROR_STOP=1 -qt
exit
