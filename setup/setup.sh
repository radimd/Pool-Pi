#!/bin/bash
BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"; cd .. ; pwd -P)

echo "Setting up pool-pi."

echo "Installing required python packages."
pip3 install -r ${BASEDIR}/setup/requirements.txt

echo "Configuring systemd."
sed -e "s/#USER#/${SUDO_USER}/g" ${BASEDIR}/setup/poolpi.template > ${BASEDIR}/setup/poolpi.service
cp ${BASEDIR}/setup/poolpi.service /etc/systemd/system/poolpi.service
chmod 644 /etc/systemd/system/poolpi.service
systemctl daemon-reload
systemctl enable redis-server
systemctl enable --now poolpi.service

echo "Setup script complete."