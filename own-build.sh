#!/bin/sh

# The dispatcher recompiles at startup to include /config/dispatcher.ex.  When
# running as an arbitrary non-root user (e.g. OpenShift) the build files are
# group-writable but owned by root, and mix needs to own them to set their
# modification times.  Copy the build so the current user owns it.
if [ "$(id -u)" != "0" ]
then
    cp -r /app/_build /app/_build.copy \
        && rm -rf /app/_build \
        && mv /app/_build.copy /app/_build
fi
