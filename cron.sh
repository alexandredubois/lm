#!/bin/sh

############### EDIT ME ##################
# path to app
APP_PATH=/c/Logiciels/Linux/scripts/lm/lm.py

# path to python bin
DAEMON=/usr/local/bin/python2.7

# path to movie folder
MOVIE_PATH=/c/media/Videos/Films/

# startup args
DAEMON_OPTS=" -a --html-build --export /c/webroot/accueil/movies/"

########### END OF EDIT ME ##############

$DAEMON $APP_PATH $MOVIE_PATH $DAEMON_OPTS

