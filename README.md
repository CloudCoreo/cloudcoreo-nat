cloudcoreo-nat
==============

NAT instance configuration

This repo is designed to work with the [CloudCoreo](http://www.cloudcoreo.com) engine. Adding this repository as a sub-module will ensure a High-uptime NAT is configured to work even in the event of a loss of availability zone.

<h3>OVERRIDE REQUIRED VARIABLES</h3>
* <b>VPC_NAME:</b>
  * required: true
  * description: this is the name of your vpc as defined by your [CloudCoreo](http://www.cloudcoreo.com) setup
* <b>PUBLIC_SUBNET_NAME:</b>
  * required: true
  * description: this is the name of the public subnet group as defined by your [CloudCoreo](http://www.cloudcoreo.com) setup

<h3>OVERRIDE OPTIONAL VARIABLES</h3>
* <b>NAT_SG_NAME:</b>
  * required: true
  * description: the name of the security group to create for the NAT
  * default: "NAT-sg"
* <b>NAT_INGRESS_PORTS:</b>
  * required: true
  * description: allowed ingress ports on the nat
  * default:
    * - "80"
    * - "443"
* <b>NAT_INGRESS_CIDRS:</b>
  * required: true
  * description: allowed ingress network cidrs on the nat
    * default :
    * - "0.0.0.0/0"
* <b>NAT_EGRESS_PORTS:</b>
  * required: true
  * description: allowed ingress ports on the nat
  * default:
    * - "0-65535"
* <b>NAT_INGRESS_CIDRS:</b>
  * required: true
  * description: allowed ingress network cidrs on the nat
    * default :
    * - "0.0.0.0/0"
* <b>NAT_NAME:</b>
  * required: true
  * description: the name of the nat instance
  * default: "NAT"
* <b>NAT_AMI:</b>
  * required: true
  * description: the ami id of the nat
  * default: "ami-d69aad93"
* <b>NAT_SIZE:</b>
  * required: true
  * description: the instance size of the nat
  * default: "m1.small"
