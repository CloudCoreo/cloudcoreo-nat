#!/usr/bin/env python

# Copyright 2014: CloudCoreo
# License: Restricted
# Author(s):
#   - Paul Allen (paul@cloudcoreo.com)

import boto
import boto.ec2
from boto.vpc import VPCConnection
import subprocess
import inspect

failit = True

def cmd_output(args, **kwds):
  kwds.setdefault("stdout", subprocess.PIPE)
  kwds.setdefault("stderr", subprocess.STDOUT)
  p = subprocess.Popen(args, **kwds)
  return p.communicate()[0]

def metaData(dataPath):
    return cmd_output(["curl", "-sL", "169.254.169.254/latest/meta-data/" + dataPath])

def getAvailabilityZone():
    return metaData("placement/availability-zone")

def getRegion():
    if not failit:
        return getAvailabilityZone()[:-1]
    else:
        return 'us-east-1'

def getInstanceId():
    return metaData("instance-id")

def findBlackholes():
    myFilters = [['vpc-id', getMyVPCId()], ['route.state', 'blackhole']]
    return vpc.get_all_route_tables(filters=myFilters)

def getMyVPCId():
    if not failit:
        return getMe().vpc_id
    else:
        return 'vpc-24974141'

def getMe():
    return ec2.get_only_instances(instance_ids=[getInstanceId()])[0]

def main():
    print getInstanceId()
    print getRegion()
    for routeTable in  findBlackholes():
        for route in routeTable.routes:
            if not route.state == 'blackhole':
                continue
            vpc.replace_route(route_table_id=routeTable.id, 
                              destination_cidr_block = route.destination_cidr_block,
                              gateway_id = route.gateway_id,
                              instance_id = getInstanceId())
                              
ec2 = boto.ec2.connect_to_region(getRegion())
vpc = boto.vpc.connect_to_region(getRegion())

main()
