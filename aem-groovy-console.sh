#!/bin/bash

PROJECT_DIR_PARENT="${HOME}/projects/aem6"
mkdir -p ${PROJECT_DIR_PARENT}
PROJECT_NAME="aem-groovy-console"
# optional 1st command line arg to override port default=4502
PORT=${1:-4502}

# optional 2nd arg to override host default=localhost (WITHOUT http://)
HOST=${2:-localhost}

echo PROJECT DIR="${PROJECT_DIR_PARENT}/${PROJECT_NAME}"
echo PORT=${PORT}

if [ ! -d "${PROJECT_DIR_PARENT}/${PROJECT_NAME}" ]; then
	cd "${PROJECT_DIR_PARENT}"
	git clone --depth 1 "https://github.com/CID15/${PROJECT_NAME}.git"
	cd "${PROJECT_NAME}"
else
	cd "${PROJECT_DIR_PARENT}/${PROJECT_NAME}"
	git pull
fi

mvn clean install -P local -Daem.port.author=${PORT} -Daem.host.author=${HOST}  -DskipTests -Dmaven.test.skip=true
open http://${HOST}:${PORT}/etc/groovyconsole.html
