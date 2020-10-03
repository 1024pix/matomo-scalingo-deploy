#!/bin/bash

echo "Generating Matomo configuration from environment"

php ./config/generate.config.ini.php

exec bash bin/run
