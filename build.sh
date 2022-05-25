#!/usr/bin/env bash

if [[ -z "${KEYCLOAK_VERSION}" ]]; then
  echo "No KEYCLOAK_VERSION environment variable set"
  exit 1
fi

echo "Downloading Keycloak ${KEYCLOAK_VERSION}..."
wget -q https://github.com/keycloak/keycloak/releases/download/${KEYCLOAK_VERSION}/keycloak-${KEYCLOAK_VERSION}.zip
echo "Unzipping Keycloak ${KEYCLOAK_VERSION}..."
unzip -q keycloak-${KEYCLOAK_VERSION}.zip
mv keycloak-${KEYCLOAK_VERSION} keycloak
rm keycloak-${KEYCLOAK_VERSION}.zip
echo "Keycloak ${KEYCLOAK_VERSION} downloaded and unzipped successfuly"

# Load the database driver, depending on the addon linked
if [[ -n "${POSTGRESQL_ADDON_URI}" ]]; then
	KC_DB="postgres"
	KC_DB_URL="jdbc:postgresql://${POSTGRESQL_ADDON_HOST}:${POSTGRESQL_ADDON_PORT}/${POSTGRESQL_ADDON_DB}"
	KC_DB_USERNAME="${POSTGRESQL_ADDON_USER}"
	KC_DB_PASSWORD="${POSTGRESQL_ADDON_PASSWORD}"
fi

if [[ -n "${MYSQL_ADDON_URI}" ]]; then
	KC_DB="mysql"
	KC_DB_URL="jdbc:mysql://${MYSQL_ADDON_HOST}:${MYSQL_ADDON_PORT}/${MYSQL_ADDON_DB}"
	KC_DB_USERNAME="${MYSQL_ADDON_USER}"
	KC_DB_PASSWORD="${MYSQL_ADDON_PASSWORD}"
fi

keycloak/bin/kc.sh build