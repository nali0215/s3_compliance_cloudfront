# s3_compliance_cloudfront
Enables versioning and server side encryption on all s3 Buckets using AWS config.
Uses terraform to setup stacks on cloudformation and set up config.
In the terraform.tfvars file must declare name, aws region, and account number.


# **_Must run config recorder first to set up AWS Config recorder or else it will fail._ 

**If you already have config recorder running you can move on to running main.tf from the cloudfront which will run iam, versioning, and encryption. 
