#!/bin/bash

echo "Generating Matomo configuration file..."

php ./scripts/generate.config.ini.php

chmod 755 ./scripts/config.ini.php

mv ./scripts/config.ini.php ./config

