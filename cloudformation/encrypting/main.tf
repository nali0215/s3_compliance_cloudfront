resource "aws_cloudformation_stack" "stack" {
  name = "s3encryptingstack"

    template_body = <<STACK
    {
  "AWSTemplateFormatVersion": "2010-09-09",
  "Metadata": {
      "AWS::CloudFormation::Designer": {
          "1d475480-04cc-498e-8864-eecbe59ac9a8": {
              "size": {
                  "width": 60,
                  "height": 60
              },
              "position": {
                  "x": 68,
                  "y": 27
              },
              "z": 0,
              "embeds": []
          },
          "100635e3-fb53-48b1-80ab-62898b178be6": {
              "size": {
                  "width": 60,
                  "height": 60
              },
              "position": {
                  "x": 153,
                  "y": 111
              },
              "z": 0,
              "embeds": []
          }
      }
  },
  "Resources": {
      "CCR29R40": {
          "Type": "AWS::Config::ConfigRule",
          "Properties": {
              "ConfigRuleName": "s3encrypting",
              "Description": "Enables server side encryption on s3 buckets",
              "Scope": {
                  "ComplianceResourceTypes": [
                      "AWS::S3::Bucket"
                  ]
              },
              "Source": {
                  "Owner": "AWS",
                  "SourceIdentifier": "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
              }
          },
          "Metadata": {
              "AWS::CloudFormation::Designer": {
                  "id": "1d475480-04cc-498e-8864-eecbe59ac9a8"
              }
          }
      },
      "CRC4A2YE": {
          "Type": "AWS::Config::RemediationConfiguration",
          "Properties": {
              "Automatic": true,
              "ConfigRuleName": {
                  "Ref": "CCR29R40"
              },
              "TargetId": "AWS-EnableS3BucketEncryption",
              "TargetType": "SSM_DOCUMENT",
              "MaximumAutomaticAttempts": 5,
              "RetryAttemptSeconds": 60,
              "Parameters": {
                  "AutomationAssumeRole": {
                      "StaticValue": {
                          "Values": [
                              "arn:aws:iam::${var.acctnumb}:role/${var.iamrole_name}"
                          ]
                      }
                  },
                  "BucketName": {
                      "ResourceValue": {
                          "Value": "RESOURCE_ID"
                      }
                  },
                  "SSEAlgorithm": {
                      "StaticValue": {
                          "Values": [
                              "AES256"
                          ]
                      }
                  }
              }
          },
          "Metadata": {
              "AWS::CloudFormation::Designer": {
                  "id": "100635e3-fb53-48b1-80ab-62898b178be6"
              }
          }
      }
  }
}
        STACK
}
