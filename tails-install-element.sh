#!/usr/bin/env bash

GPG_LOCAL_FILE="${PWD}/riot-im-archive-keyring.gpg"
GPG_TRUSTED_FILE="/etc/apt/trusted.gpg.d/riot-im-archive-keyring.gpg"

if [[ -f "${GPG_LOCAL_FILE}" ]]; then
    cp -R "${GPG_LOCAL_FILE}" "${GPG_TRUSTED_FILE}"
    gpg --import ${GPG_TRUSTED_FILE} && echo "GPG key added"
    echo "deb [trusted=yes] tor+https://packages.riot.im/debian/ default main" | tee /etc/apt/sources.list.d/riot-im.list
    gpg --export --armor D7B0B66941D01538 | apt-key add -
    apt update && echo "APT updated successfully"
    apt install -y element-desktop
fi
