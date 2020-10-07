#!/bin/bash

echo "Activating Matomo Tag Manager..."

if [[ "$MATOMO_TAG_MANAGER_ENABLED" == true ]]; then
  php console plugin:activate "TagManager"
fi

echo "Activating Matomo purchased plugins..."

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

      echo "Activating $plugin_name"
      php console plugin:activate "$plugin_name"
    done
  fi
fi
