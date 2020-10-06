#!/bin/bash

echo "Installing and activating Matomo purchased plugins..."

if [[ -z "$MATOMO_LICENSE_KEY" ]]; then
  echo "Do not fetch purchased plugins because no Matomo plugins API license key defined"
else
  if [[ -z "$MATOMO_PURCHASED_PLUGINS" ]]; then
    echo "No purchased plugins specified. Did you forgotten to set MATOMO_PURCHASED_PLUGINS variable?"
  else
    plugins_dir="./plugins"

    mkdir -p "${PWD}/$plugins_dir"

    IFS=',' read -ra plugins <<<"$MATOMO_PURCHASED_PLUGINS"
    for plugin in "${plugins[@]}"; do
      plugin_name=${plugin%%:*}
      plugin_version=${plugin##*:}

      access_token="$MATOMO_LICENSE_KEY"
      zip_file_name="$plugin_name.zip"
      zip_file_location="$plugins_dir/$zip_file_name"
      url="https://plugins.matomo.org/api/2.0/plugins/$plugin_name/download/$plugin_version"

      echo "Downloading plugin $plugin_name#$plugin_version at $url to $zip_file_location"
      if curl -X POST -F "access_token=$access_token" -L "${url}" -o "$zip_file_location"; then

        echo "Unzipping $zip_file_location to $plugins_dir/$plugin_name"
        unzip "$zip_file_location" -d "$plugins_dir"

        if [[ -f "$zip_file_location" ]]; then
          echo "Removing $zip_file_location"
          rm -f "$zip_file_location"

          echo "Activating plugin $plugin_name in Matomo"
          php console plugin:activate "$plugin_name"
        fi
      else
        echo "Something went wrong"
      fi
    done
    IFS=' '
  fi
fi
