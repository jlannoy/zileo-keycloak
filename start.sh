#!/bin/bash

# If the hostname is not defined, we remove the strict hostname feature.
# For production, you must define KC_HOSTNAME variable
if [[ -z "${KC_HOSTNAME}" ]]; then
	KC_HOSTNAME_STRICT="false"
fi

echo "Sarting KC";
echo "${KC_DB}";

# Check if a postgres or mysql addon is linked to this application, in order to get the URI of database
if [[ -z "${POSTGRESQL_ADDON_URI}" ]]; then
	KC_DB="postgres"
	KC_DB_URL="jdbc:${POSTGRESQL_ADDON_URI}"
fi

if [[ -z "${MYSQL_ADDON_URI}" ]]; then
	KC_DB="mysql"
	KC_DB_URL="jdbc:${MYSQL_ADDON_URI}"
fi

echo "${POSTGRESQL_ADDON_URI}";
echo "${MYSQL_ADDON_URI}";
echo "${KC_DB}";

keycloak/bin/kc.sh start --proxy edge
