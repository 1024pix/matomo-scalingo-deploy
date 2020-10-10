#!/bin/bash

if [[ -z "$MATOMO_AUTO_ARCHIVING_FREQUENCY" ]]; then
  echo "Auto-archiving reports job disabled"
else
  bin/generate-config-ini.sh

  echo "Start auto-archiving reports CRON job"
  while true; do
    echo "Archiving reports... "
    php console core:archive --url "$MATOMO_BASE_URL"
    echo "done"
    sleep "$MATOMO_AUTO_ARCHIVING_FREQUENCY"
  done
fi
