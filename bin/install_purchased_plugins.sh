#!/bin/bash

echo "Installing and activating Matomo purchased plugins"

purchased_plugins=(
  "Funnels:3.1.22"
  "ActivityLog:3.4.0"
  "RollUpReporting:3.2.7"
  "MultiChannelConversionAttribution:3.0.7"
)

for plugin in "${purchased_plugins[@]}" ; do
  plugin_name=${plugin%%:*}
  plugin_version=${plugin##*:}

  access_token="${MATOMO_PLUGINS_API_LICENSE_KEY}"
  filename="plugins/${plugin_name}.zip"
  url="https://plugins.matomo.org/api/2.0/plugins/${plugin_name}/download/${plugin_version}"

  echo "Downloading plugin ${filename} at ${url}"
  if curl -X POST -F "access_token=${access_token}" -L "${url}" -o "${filename}"; then

      echo "Unzipping ${filename} to plugins/${plugin_name}"
      unzip "${filename}" -d plugins

      if [[ -f "${PWD}/${filename}" ]]; then
          echo "Removing ${filename}"
          rm -f "${PWD}/${filename}"

          echo "Activating plugin ${plugin_name} in Matomo"
          php console plugin:activate "${plugin_name}"
      fi
  else
      echo "Something went wrong"
  fi
done
