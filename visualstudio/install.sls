# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import visualstudio with context %}

    {%- if grains.os == 'Windows' %}

visualstudio-software-install:
  file.managed:
    - name: {{ visualstudio.dir.tmp }}{{ visualstudio.div }}visualstudio-installer.exe
    - source: {{ visualstudio.pkg.source }}
    - skip_verify: {{ visualstudio.pkg.skip_verify }}
    - unless: test -f {{ visualstudio.dir.tmp }}{{ visualstudio.div }}visualstudio-installer.exe
    - makedirs: True
    - retry: {{ visualstudio.retry_option|json }}
  cmd.run:
    - name: {{ visualstudio.dir.tmp }}{{ visualstudio.div }}visualstudio-installer.exe
    - require:
      - file: visualstudio-software-install

    {%- else %}

visualstudio-buildtols-software-install:
  test.show_notification:
    - text: |
        The installer software is unavailable/unselected for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
