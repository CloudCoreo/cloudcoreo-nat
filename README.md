cloudcoreo-nat
==============

NAT instance configuration

This repo is designed to work with the [CloudCoreo](http://www.cloudcoreo.com) engine. Adding this repository as a submodule will ensure a High-uptime NAT is configued to work even in the event of a loss of availability zone.

<h2>OVERRIDE REQUIRED VARIABLES</h2>
* VPC_NAME:
..* required: true
..* description: this is the name of your vpc as defined by your [CloudCoreo](http://www.cloudcoreo.com) setup
* PUBLIC_SUBNET_NAME:
..* required: true
..* description: this is the name of the public subnet group as defined by your [CloudCoreo](http://www.cloudcoreo.com) setup

OVERRIDE OPTIONAL VARIABLES
variables:
    NAT_SG_NAME:
        required: true
        description: the name of the security group to create for the NAT
        default: "NAT-sg"
    NAT_INGRESS_PORTS:
        required: true
        description: allowed ingress ports on the nat
        default:
            - "80"
            - "443"
    NAT_INGRESS_CIDRS:
        required: true
        description: allowed ingress network cidrs on the nat
	default :
            - "0.0.0.0/0"
    NAT_EGRESS_PORTS:
        required: true
        description: allowed ingress ports on the nat
        default:
            - "0-65535"
    NAT_INGRESS_CIDRS:
        required: true
        description: allowed ingress network cidrs on the nat
	default :
            - "0.0.0.0/0"
    NAT_NAME:
        required: true
        description: the name of the nat instance
        default: "NAT"
    NAT_AMI:
        required: true
        description: the ami id of the nat
        default: "ami-d69aad93"
    NAT_SIZE:
        required: true
        description: the instance size of the nat
        default: "m1.small"
