#!/bin/sh

## make sure pip is installed
if ! rpm -qa | grep -q python-pip; then
    yum install -y python-pip
fi

## make sure we have the latest boto installed
pip install boto --upgrade
