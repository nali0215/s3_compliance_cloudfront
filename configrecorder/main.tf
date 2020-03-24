
resource "aws_config_configuration_recorder_status" "recorderstatus" {
  name       = "${aws_config_configuration_recorder.configrecorder.name}"
  is_enabled = true
  depends_on = ["aws_config_delivery_channel.configdelivery"]
}

resource "aws_iam_role_policy_attachment" "attachment" {
  role       = "${aws_iam_role.configrole.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

resource "aws_s3_bucket" "configbucket" {
  bucket = "${var.bucket_name}"
}

resource "aws_config_delivery_channel" "configdelivery" {
  name           = "configdelivery"
  s3_bucket_name = "${aws_s3_bucket.configbucket.bucket}"
}

resource "aws_config_configuration_recorder" "configrecorder" {
  name     = "example"
  recording_group {
  all_supported = "true"
  include_global_resource_types = "true"
  }
  role_arn = "${aws_iam_role.configrole.arn}"
}

resource "aws_iam_role" "configrole" {
  name = "awsconfig"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "configpolicy" {
  name = "awsconfig-policy"
  role = "${aws_iam_role.configrole.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.configbucket.arn}",
        "${aws_s3_bucket.configbucket.arn}/*"
      ]
    }
  ]
}
POLICY
}
