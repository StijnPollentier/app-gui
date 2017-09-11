#!/bin/bash - 
#===============================================================================
#         USAGE: ./create_container.sh 
#       OPTIONS: ---
#
#        AUTHOR: Simon Esprit, simon.esprit@daltix.eu
#       CREATED: 03/13/2017 11:23
#   DESCRIPTION: Use this script to (re)create a Docker container containing
#                the daltix postgres database.
#===============================================================================

# set -o nounset                              
# Treat unset variables as an error

docker build -t daltix/hive-dashboard-db .
docker stop hive-dashboard-db
docker rm hive-dashboard-db
docker run -it --name hive-dashboard-db -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d daltix/hive-dashboard-db

echo "connect using psql:"
echo "psql --host localhost --port 5432 -U daltix hive_db"
