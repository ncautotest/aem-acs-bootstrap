#!/bin/bash

PROJECT_DIR_PARENT="${HOME}/projects/aem6"
mkdir -p ${PROJECT_DIR_PARENT}
PROJECT_NAME="acs-aem-tools"

# pass custom port as 1st command line argument or use 4502 by default
PORT=${1:-4502}

echo PROJECT DIR="${PROJECT_DIR_PARENT}/${PROJECT_NAME}"
echo PORT=${PORT}

if [ ! -d "${PROJECT_DIR_PARENT}/${PROJECT_NAME}" ]; then
	mkdir -p "${PROJECT_DIR_PARENT}"
	cd "${PROJECT_DIR_PARENT}"
	git clone --depth 1 "https://github.com/Adobe-Consulting-Services/${PROJECT_NAME}.git"
	cd "${PROJECT_DIR_PARENT}/${PROJECT_NAME}"
else
	cd "${PROJECT_DIR_PARENT}/${PROJECT_NAME}"
	git pull
fi

mvn clean -PautoInstallPackage  -Dmaven.test.skip=true install -Dcrx.port=${PORT}
open http://localhost:${PORT}/miscadmin#/etc/acs-tools
