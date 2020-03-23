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
  remediationARN = "${module.iam.iam_role_arn}"

}
# Deploy Storage Resources
module "versioning" {
  source       = "./versioning"
  iamrole_name = "${var.iamrole_name}"
  acctnumb     = "${var.acctnumb}"
  remediationARN = "${module.iam.iam_role_arn}"

}
