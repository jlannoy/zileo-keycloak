#!/bin/bash

# If the hostname is not defined, we remove the strict hostname feature.
# For production, you must define KC_HOSTNAME variable
if [[ -z "${KC_HOSTNAME}" ]]; then
	KC_HOSTNAME_STRICT="false"
fi

echo "Check";

echo "${KC_HOSTNAME}";

echo "${POSTGRESQL_ADDON_HOST}";

# Check if a postgres or mysql addon is linked to this application, in order to get the URI of database
if [[ -z "${POSTGRESQL_ADDON_HOST}" ]]; then
	export KC_DB_URL="jdbc:postgresql://${POSTGRESQL_ADDON_HOST}:${POSTGRESQL_ADDON_PORT}/${POSTGRESQL_ADDON_DB}"
	export KC_DB_USERNAME="$POSTGRESQL_ADDON_USER"
	export KC_DB_PASSWORD="$POSTGRESQL_ADDON_PASSWORD"
fi

if [[ -z "${MYSQL_ADDON_HOST}" ]]; then
	KC_DB_URL="jdbc:${MYSQL_ADDON_HOST}"
fi


keycloak/bin/kc.sh start --proxy edge
