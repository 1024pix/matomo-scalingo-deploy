#!/bin/bash

if [[ -z "$MATOMO_LICENSE_KEY" ]]; then
  echo "Not activating purchased plugins because no Matomo plugins API license key defined"
else
  if [[ -z "$MATOMO_PURCHASED_PLUGINS" ]]; then
    echo "No purchased plugins specified. Did you forgotten to set MATOMO_PURCHASED_PLUGINS variable?"
  else
    if [ -z "$MATOMO_PLUGINS" ]; then
        MATOMO_PLUGINS="$MATOMO_PURCHASED_PLUGINS"
    else
        MATOMO_PLUGINS="$MATOMO_PLUGINS,$MATOMO_PURCHASED_PLUGINS"
    fi
  fi
fi

if [[ "$MATOMO_PLUGINS" ]]; then
  IFS=',' read -ra plugins <<<"$MATOMO_PLUGINS"

  for plugin in "${plugins[@]}"; do
    plugin_name=${plugin%%:*}

    echo "Activating $plugin_name"
    php console plugin:activate "$plugin_name"
  done
fi
