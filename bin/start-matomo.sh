#!/bin/bash

bin/generate-config-ini.sh

bin/install-purchased-plugins.sh

exec bash bin/run
