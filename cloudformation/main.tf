provider "aws" {
  region = "${var.aws_region}"
}

# Deploy iam Resources
module "iam" {
  source       = "./iam"
  iamrole_name = "${var.iamrole_name}"

}

# Deploy encrypting cloudformation
module "encrypting" {
  source       = "./encrypting"
  iamrole_name = "${var.iamrole_name}"
  acctnumb     = "${var.acctnumb}"

}
# Deploy Storage Resources
module "versioning" {
  source       = "./versioning"
  iamrole_name = "${var.iamrole_name}"
  acctnumb     = "${var.acctnumb}"

}
