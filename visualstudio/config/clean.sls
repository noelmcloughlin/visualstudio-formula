# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import visualstudio with context %}

    {%- if visualstudio.environ_file %}
        {%- set sls_clean = tplroot ~ '.clean' %}

include:
  - {{ sls_clean }}

visualstudio-config-clean-file-absent:
  file.absent:
    - name: {{ visualstudio.environ_file }}
    - require:
      - sls: {{ sls_clean }}

    {%- endif %}
