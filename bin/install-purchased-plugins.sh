#!/bin/bash

echo "Installing and activating Matomo purchased plugins"

if [[ -z "$MATOMO_LICENSE_KEY" ]]; then
  echo "Do not fetch purchased plugins because no Matomo plugins API license key defined"
else
  if [[ -z "$MATOMO_PURCHASED_PLUGINS" ]]; then
    echo "No purchased plugins specified. Did you forgotten to set MATOMO_PURCHASED_PLUGINS variable?"
  else
    purchased_plugins=$(echo "$MATOMO_PURCHASED_PLUGINS" | tr "," "\n")

    for plugin in "${purchased_plugins[@]}"; do
      plugin_name=${plugin%%:*}
      plugin_version=${plugin##*:}

      access_token="$MATOMO_LICENSE_KEY"
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
  fi
fi
