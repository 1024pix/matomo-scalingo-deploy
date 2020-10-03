#!/bin/bash

set -eu

echo "Generate Matomo config"

mv ./scalingo/config/* ./config

php ./config/generate.config.ini.php
