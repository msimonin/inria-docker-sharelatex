#!/bin/bash

# This will add a local user with uid/gid passed from the environment variable
# SHARELATEX_UID: uid to use
# SHARELATEX_GID: gid to use
# This entry point is primarily done to give the container permission to the
# sesame data on G5K (the use needs to be on the right sesame group)
if [[ ! -z "$SHARELATEX_UID" && ! -z "$SHARELATEX_GID" ]]
then
    echo "Starting using UID=$SHARELATEX_UID" and GID="$SHARELATEX_GID"
    groupadd sharelatex -g $SHARELATEX_GID
    useradd --shell /bin/bash -u $SHARELATEX_UID -g $SHARELATEX_GID -o -c "" -m sharelatex
    echo "Changing permission on /opt/sharelatex"
    chown sharelatex:sharelatex -R /opt/sharelatex || true
    sync
    # https://github.com/tianon/gosu
    exec gosu sharelatex "$@" 
else
    exec "$@"
fi
