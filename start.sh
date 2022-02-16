echo "*** HOST = ${KEYCLOAK_HOSTNAME}"

keycloak/bin/kc.sh start --hostname ${KEYCLOAK_HOSTNAME} --db-url 'jdbc:postgresql://${POSTGRESQL_ADDON_HOST}:${POSTGRESQL_ADDON_PORT}/${POSTGRESQL_ADDON_DB}' --db-username ${POSTGRESQL_ADDON_USER} --db-password ${POSTGRESQL_ADDON_PASSWORD} --http-enabled true