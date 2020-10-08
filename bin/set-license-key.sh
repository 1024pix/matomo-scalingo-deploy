#!/bin/bash

echo "Setting license key..."

if [[ -z "$MATOMO_LICENSE_KEY" ]]; then
  php console license:set "$MATOMO_LICENSE_KEY"
fi
