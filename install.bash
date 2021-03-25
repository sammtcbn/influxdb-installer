#!/bin/bash
SERVICE_NAME=influxdb.service
INS_PATH=/usr/local/sammtcbn/influxdb

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

mkdir -p ${INS_PATH} || exit 1
cp -a -f archives/* ${INS_PATH} || exit 1
cp -a -f ${SERVICE_NAME} /etc/systemd/system || exit 1

systemctl daemon-reload || exit 1
chmod 664 /etc/systemd/system/${SERVICE_NAME} || exit 1
systemctl enable ${SERVICE_NAME} || exit 1
systemctl start ${SERVICE_NAME} || exit 1
