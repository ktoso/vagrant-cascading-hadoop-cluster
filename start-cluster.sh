#!/bin/sh

vagrant up
vagrant ssh master

sudo start-all.sh
sleep 20s
sudo /opt/hbase-0.94.10/bin/start-hbase.sh
