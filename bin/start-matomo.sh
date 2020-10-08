#!/bin/bash

echo "Starting Matomo application..."

bin/fetch-purchased-plugins.sh

bin/generate-config-ini.sh

bin/set-license-key.sh

bin/activate-plugins.sh

exec bash bin/run
