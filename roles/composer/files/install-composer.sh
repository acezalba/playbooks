#!/bin/sh

set -e

VERSION="$1"   # Optional, e.g. "2.7.9"
TARGET="/usr/local/bin/composer"

# If Composer exists, check its version
if [ -x "$TARGET" ]; then
    INSTALLED_VERSION="$($TARGET --version --no-ansi | awk '{print $3}')"
    if [ -n "$VERSION" ]; then
        if [ "$INSTALLED_VERSION" = "$VERSION" ]; then
            echo "Composer $VERSION is already installed."
            exit 0
        else
            echo "Composer $INSTALLED_VERSION is installed, upgrading/downgrading to $VERSION..."
        fi
    else
        echo "Composer $INSTALLED_VERSION is already installed."
        exit 0
    fi
fi

# Always work in /tmp
cd /tmp

EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

if [ -n "$VERSION" ]; then
    php composer-setup.php --quiet --version="$VERSION"
else
    php composer-setup.php --quiet
fi

rm composer-setup.php

mv composer.phar "$TARGET"
chmod +x "$TARGET"

echo "Composer installed at $TARGET"
