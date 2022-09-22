#!/bin/bash
echo "Use matomo nginx config."
test -f conf/matomo.conf.erb && cp -f conf/matomo.conf.erb conf/site.conf.erb
