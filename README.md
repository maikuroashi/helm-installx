# Helm Installx Plugin

This plugin extends the Helm install command to merge value YAML files specified with the ```-f``` or ```--values``` options into a single values file using ```yq```. This allows value files to be YAML fragments which can override and extend previous value files provided the merged values files form a valid values file.

## Usage

```sh
helm installx [NAME] [CHART] [flags]

Flags: All the install command flags are supported.
```

## Install

```sh
$ helm plugin install https://github.com/maikuroashi/helm-installx
Installed plugin: installx
```
