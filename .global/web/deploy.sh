#!/bin/bash

PROJECT_NAME="kishax-web"
SERVICE_NAME="kishaxweb"
DEV_USER="bella"
WEB_USER="nodeuser"
SOURCE_PATH="/home/${DEV_USER}/git/${PROJECT_NAME}"
DEPLOY_PATH="/home/${WEB_USER}/git"
PROJECT_PATH="${DEPLOY_PATH}/${PROJECT_NAME}"

sudo systemctl stop ${SERVICE_NAME}

if [ -d "${PROJECT_PATH}" ]; then
  rm -rf $PYENV_ROOT/bin
fi

cp -pr "${SOURCE_PATH}" "${DEPLOY_PATH}/"

sudo chmod -R 755 "${PROJECT_PATH}"
sudo chown -R nodeuser:nodeuser "${PROJECT_PATH}"
sudo chmod g+s "${PROJECT_PATH}"

sudo setfacl -R -m u:${DEV_USER}:rwx "${PROJECT_PATH}"
sudo setfacl -dR -m u:${DEV_USER}:rwx "${PROJECT_PATH}"
sudo setfacl -d -m other:r-x "${PROJECT_PATH}"

if [ -f "${PROJECT_PATH}/.env" ]; then
  sudo chmod 770 "${PROJECT_PATH}/.env"
fi

sudo systemctl restart ${SERVICE_NAME}
