#!/bin/bash

echo "Setting license key..."

if [[ -n "$MATOMO_LICENSE_KEY" ]]; then
  php console license:set --licenseKey="$MATOMO_LICENSE_KEY"
fi
