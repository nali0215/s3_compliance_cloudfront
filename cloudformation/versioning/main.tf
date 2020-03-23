resource "aws_cloudformation_stack" "s3versioningstack" {
  name = "s3versioningstack"

  template_body = <<STACK
  {
      "AWSTemplateFormatVersion": "2010-09-09",
      "Metadata": {
          "AWS::CloudFormation::Designer": {
              "3336a676-a8b1-4c52-9e66-a5d65f60b9a2": {
                  "size": {
                      "width": 60,
                      "height": 60
                  },
                  "position": {
                      "x": 150,
                      "y": 60
                  },
                  "z": 1,
                  "embeds": []
              },
              "bc4c9c12-fdf6-4da7-9787-acba4c5dd05a": {
                  "size": {
                      "width": 60,
                      "height": 60
                  },
                  "position": {
                      "x": 60,
                      "y": 150
                  },
                  "z": 1,
                  "embeds": [],
                  "dependson": [
                      "3336a676-a8b1-4c52-9e66-a5d65f60b9a2"
                  ]
              },
              "cb32f275-2404-4e7b-8e6a-c44e48d8ff0c": {
                  "source": {
                      "id": "bc4c9c12-fdf6-4da7-9787-acba4c5dd05a"
                  },
                  "target": {
                      "id": "3336a676-a8b1-4c52-9e66-a5d65f60b9a2"
                  },
                  "z": 2
              }
          }
      },
      "Resources": {
          "CCR4GCAY": {
              "Type": "AWS::Config::ConfigRule",
              "Properties": {
                  "ConfigRuleName": "s3versioning",
                  "Description": "Enables versioning on s3 buckets",
                  "Scope": {
                      "ComplianceResourceTypes": [
                          "AWS::S3::Bucket"
                      ]
                  },
                  "Source": {
                      "Owner": "AWS",
                      "SourceIdentifier": "S3_BUCKET_VERSIONING_ENABLED"
                  }
              },
              "Metadata": {
                  "AWS::CloudFormation::Designer": {
                      "id": "3336a676-a8b1-4c52-9e66-a5d65f60b9a2"
                  }
              }
          },
          "CRC1RSTS": {
              "Type": "AWS::Config::RemediationConfiguration",
               "Properties": {
                  "Automatic": true,
                  "ConfigRuleName": {
                      "Ref": "CCR4GCAY"
                  },
                  "TargetId": "AWS-ConfigureS3BucketVersioning",
                  "TargetType": "SSM_DOCUMENT",
                  "MaximumAutomaticAttempts": 5,
                  "RetryAttemptSeconds": 60,

                  "Parameters": {
                      "AutomationAssumeRole": {
                          "StaticValue": {
                              "Values": [
                                  "${var.remediationARN}"
                              ]
                          }
                      },
                      "BucketName": {
                          "ResourceValue": {
                              "Value": "RESOURCE_ID"
                          }
                      },
                      "VersioningState": {
                          "StaticValue": {
                              "Values": [
                                  "Enabled"
                              ]
                          }
                      }
                  }
              },
              "Metadata": {
                  "AWS::CloudFormation::Designer": {
                      "id": "bc4c9c12-fdf6-4da7-9787-acba4c5dd05a"
                  }
              }

          }

      }
  }
STACK
}
