
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

coreo_aws_iam_policy "${NAT_NAME}" do
  action :sustain
  policy_name "AllowVpcManagement"
  policy_document <<-EOH
{
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
          "*"
      ],
      "Action": [ 
          "ec2:DeleteTags",
          "ec2:DescribeAvailabilityZones",                                                                                                                                                                          
          "ec2:ModifyInstanceAttribute",
          "ec2:DescribeInstanceAttribute",
          "ec2:DescribeInstanceStatus",
          "ec2:DescribeInstances",
          "ec2:DescribePlacementGroups",
          "ec2:DescribeRegions",
          "ec2:DescribeTags",
          "ec2:ModifyInstanceAttribute",
          "ec2:ReportInstanceStatus",
          "ec2:DescribeSecurityGroups",
          "ec2:ReplaceRoute",
          "ec2:CreateRoute",
          "ec2:ReplaceRouteTableAssociation",
          "ec2:DescribeSubnets",
          "ec2:DescribeRouteTables"
      ]
    }
  ]
}
EOH
end

coreo_aws_iam_role "${NAT_NAME}" do
  action :sustain
  trust_document <<-EOH
{
    "Version":"2008-10-17",
    "Statement":
    [
        {
            "Effect":"Allow",
            "Principal":{
                "Service":
                [
                    "ec2.amazonaws.com"
                ]
            },
            "Action":
            [
                "sts:AssumeRole"
            ]
        }
    ]
}
EOH
  policies ["${NAT_NAME}"]
end

coreo_aws_ec2_instance "${NAT_NAME}" do
  action :define
  image_id "${NAT_AMI}"
  size "${NAT_SIZE}"
  security_groups ["${NAT_SG_NAME}"]
  associate_public_ip true
  role "${NAT_NAME}"
end

coreo_aws_ec2_autoscaling "${NAT_NAME}" do
  action :sustain 
  scheme "one_running"
  minimum 1
  maximum 1
  server_definition "${NAT_NAME}"
  subnet "${PUBLIC_SUBNET_NAME}"
end
