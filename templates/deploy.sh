#!/bin/bash
pwd
{% if pgdeploy_password is defined %}PGPASSWORD="{{ pgdeploy_password }}" {% endif %}
psql -U {{pgdeploy_user}} -h {{pgdeploy_host}} -d {{ pgdeploy_db }} -p {{ pgdeploy_port }} \
  -qt \
  {% for key, value in pgdeploy_vars.items() %} -v {{ key }}={{ value }}{% endfor %} -1f {{ pgdeploy_entrypoint }}
