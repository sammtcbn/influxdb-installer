#!/bin/bash

INFLUXDB_VER=1.8.0
INFLUXDB_TARBALL=influxdb-${INFLUXDB_VER}-static_linux_amd64.tar.gz

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
  rm -rf influxdb-${INFLUXDB_VER}-1 || exit 1
  tar zxfv ${INFLUXDB_TARBALL} || exit 1
  rm -rf influxdb-${INFLUXDB_VER}-1/var || exit 1
}

function clean()
{
  rm -rf influxdb-${INFLUXDB_VER}-1/usr || exit 1
}

function collect()
{
  mv influxdb-${INFLUXDB_VER}-1/ archives || exit 1
}

rm -rf ${ARCHIVES_TOP} || exit 1

download
extract
clean
collect

echo "done"
