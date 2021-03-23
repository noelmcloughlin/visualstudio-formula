# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import visualstudio with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- if visualstudio.environ and 'path' in visualstudio.config %}
        {%- set sls_install = tplroot ~ '.install' %}

include:
  - {{ sls_install }}

visualstudio-config-file-managed-environ_file:
  file.managed:
    - name: {{ visualstudio.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='visualstudio-config-file-managed-environ_file'
                 )
              }}
    - makedirs: True
    - template: jinja
    - context:
        path: {{ visualstudio.config.path|json }}
        environ: {{ visualstudio.environ|json }}
    - require:
      - sls: {{ sls_install }}

    {%- endif %}
