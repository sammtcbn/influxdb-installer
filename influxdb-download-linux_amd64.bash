#!/bin/bash

INFLUXDB_VER=1.8.9
INFLUXDB_TARBALL=influxdb-${INFLUXDB_VER}-static_linux_amd64.tar.gz
INFLUXDB_FOLDER_NAME=influxdb-${INFLUXDB_VER}-1
INFLUXDB_CONF=influxdb.conf

DB_DEF_ROOT_PATH=/var/lib/influxdb
DB_NEW_ROOT_PATH=/usr/local/sammtcbn/influxdb

CURRDIR=$(cd $(dirname $0) && pwd)
ARCHIVES_TOP=${CURRDIR}/archives

function download()
{
  if [ ! -f ${INFLUXDB_TARBALL} ];then
    curl -f --output ${INFLUXDB_TARBALL} https://dl.influxdata.com/influxdb/releases/${INFLUXDB_TARBALL} || exit 1
  fi
}

function extract()
{
  rm -rf ${INFLUXDB_FOLDER_NAME} || exit 1
  tar zxfv ${INFLUXDB_TARBALL} || exit 1
}

function clean()
{
  rm -rf ${INFLUXDB_FOLDER_NAME}/usr || exit 1
}

function collect()
{
  mv ${INFLUXDB_FOLDER_NAME}/ archives || exit 1
  sed -i "s|${DB_DEF_ROOT_PATH}|${DB_NEW_ROOT_PATH}|g" archives/${INFLUXDB_CONF} || exit 1
  cp -f uninstall.bash archives/ || exit 1
}

rm -rf ${ARCHIVES_TOP} || exit 1

download
extract
clean
collect

echo "done"
