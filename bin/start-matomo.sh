#!/bin/bash

set -eu

echo "Generating Matomo configuration from environment"

bin/generate_config.sh
bin/install_scalingo_plugins.sh
#bin/install_purchased_plugins.sh

exec bash bin/run
