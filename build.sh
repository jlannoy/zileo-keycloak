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
	export KC_DB="postgres"
fi

if [[ -n "${MYSQL_ADDON_URI}" ]]; then
	export KC_DB="mysql"
fi

cp custom-themes/* keycloak/themes/

keycloak/bin/kc.sh build
