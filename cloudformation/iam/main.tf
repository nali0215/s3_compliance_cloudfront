resource "aws_iam_role" "AutomationRoleAWS" {
  name = "${var.iamrole_name}"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
    {
  "Effect": "Allow",
  "Principal": {
    "Service": [
      "ec2.amazonaws.com",
      "ssm.amazonaws.com"
          ]
        },
  "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF
}
resource "aws_iam_role_policy" "automation_policy" {
  name = "automation_policy"
  role = aws_iam_role.AutomationRoleAWS.id

  policy = <<-EOF
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "lambda:InvokeFunction"
              ],
              "Resource": [
                  "arn:aws:lambda:*:*:function:Automation*"
              ]
          },
          {
              "Effect": "Allow",
              "Action": [
                  "ec2:CreateImage",
                  "ec2:CopyImage",
                  "ec2:DeregisterImage",
                  "ec2:DescribeImages",
                  "ec2:DeleteSnapshot",
                  "ec2:StartInstances",
                  "ec2:RunInstances",
                  "ec2:StopInstances",
                  "ec2:TerminateInstances",
                  "ec2:DescribeInstanceStatus",
                  "ec2:CreateTags",
                  "ec2:DeleteTags",
                  "ec2:DescribeTags",
                  "cloudformation:CreateStack",
                  "cloudformation:DescribeStackEvents",
                  "cloudformation:DescribeStacks",
                  "cloudformation:UpdateStack",
                  "cloudformation:DeleteStack"
              ],
              "Resource": [
                  "*"
              ]
          },
          {
              "Effect": "Allow",
              "Action": [
                  "ssm:*"
              ],
              "Resource": [
                  "*"
              ]
          },
          {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        },
          {
              "Effect": "Allow",
              "Action": [
                  "sns:Publish"
              ],
              "Resource": [
                  "arn:aws:sns:*:*:Automation*"
              ]
          },
          {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "arn:aws:iam::465614246347:role/arn:aws:iam::465614246347:role/AwsAutomationRole"
        }

      ]
  }
  EOF
}
