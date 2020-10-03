#!/bin/bash

set -eu

echo "Installing and activating Matomo Scalingo plugins"

mv ./scalingo/plugins/* ./plugins

php console plugin:activate EnvironmentVariables
php console plugin:activate DbCommands
php console plugin:activate AdminCommands
