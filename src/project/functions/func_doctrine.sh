#! /bin/bash

database_create() {
  php bin/console \
    doctrine:database:create \
    --if-not-exists \
    --no-interaction \
    --env="${APP_RUNTIME_ENV}"
}

database_drop() {
  php bin/console \
    doctrine:database:drop \
    --force \
    --if-exists \
    --no-interaction \
    --env="${APP_RUNTIME_ENV}"
}

migrate() {
  php bin/console \
    doctrine:migrations:migrate \
    --no-interaction \
    --env="${APP_RUNTIME_ENV}"
}

schema_drop() {
  php bin/console \
    doctrine:schema:drop \
    --force \
    --full-database \
    --no-interaction \
    --env="${APP_RUNTIME_ENV}"
}
