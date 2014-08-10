#!/bin/sh

## variables:
##   - MONITORINTERVAL
##   - LOGFILE
##   - PRIVATE_SUBNETS

(
    yum install -y ha-nat
    cd /opt/
    nohup ./ha-nat.py --monitor-interval $MONITORINTERVAL --log-file $LOGFILE --private-subnets $PRIVATE_SUBNETS &
    echo "* * * * * ps -fwwC python | grep -q ha-nat || { cd /opt/; nohup ./ha-nat.py --monitor-interval $MONITORINTERVAL --log-file $LOGFILE --private-subnets $PRIVATE_SUBNETS & }" | crontab
)
