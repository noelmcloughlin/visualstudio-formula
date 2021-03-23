# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import visualstudio with context %}

visualstudio-clean-download:
  file.absent:
    - name: {{ visualstudio.dir.tmp }}

