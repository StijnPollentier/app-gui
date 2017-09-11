##############################################################
# Dockerfile to set up the Daltix postgres databases.
##############################################################
FROM postgres:latest
MAINTAINER Simon Esprit

ENV POSTGRES_USER hive_db

# create proper users and roles
COPY access_control.sql /docker-entrypoint-initdb.d/00.sql
COPY set_dummy_passwords.sql /docker-entrypoint-initdb.d/01.sql

# create the various tables
COPY tables.sql /docker-entrypoint-initdb.d/10.sql

# add shops data
COPY insert_shops.sql /docker-entrypoint-initdb.d/11.sql
COPY insert_locations.sql /docker-entrypoint-initdb.d/12.sql
COPY insert_cg_locations.sql /docker-entrypoint-initdb.d/13.sql

# insert dummy data
COPY metrics_data.sql /docker-entrypoint-initdb.d/20.sql
COPY remarkable_results.sql /docker-entrypoint-initdb.d/21.sql

RUN chmod a+r /docker-entrypoint-initdb.d/*

