
coreo_aws_ec2_securityGroups "${NAT_SG_NAME}" do
  action :sustain
  description "NAT security group"
  vpc "${VPC_NAME}"
  allows [ 
          { 
            :direction => :ingress,
            :protocol => :tcp,
            :ports => ${NAT_INGRESS_PORTS},
            :cidrs => ${NAT_INGRESS_CIDRS},
          },
          { 
            :direction => :egress,
            :protocol => :tcp,
            :ports => ${NAT_EGRESS_PORTS},
            :cidrs => ${NAT_EGRESS_CIDRS},
          }
    ]
end

coreo_aws_ec2_instance "${NAT_NAME}" do
  action :define
  image_id "${NAT_AMI}"
  size "${NAT_SIZE}"
  security_groups ["${NAT_SG_NAME}"]
end

coreo_aws_ec2_autoscaling "${NAT_NAME}" do
  action :sustain 
  scheme "one_running"
  minimum 1
  maximum 1
  server_definition "${NAT_NAME}"
  subnet "${PUBLIC_SUBNET_NAME}"
end
