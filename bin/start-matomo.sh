#!/bin/bash

echo "Generating Matomo configuration from environment"

ls -la

php ./config/generate.config.ini.php

exec bash bin/run
