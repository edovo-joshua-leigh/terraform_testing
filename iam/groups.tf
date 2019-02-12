resource "aws_iam_group" "developers" {
  name = "developers"
}

resource "aws_iam_group_policy_attachment" "self_manage" {
  group      = "${aws_iam_group.developers.name}"
  policy_arn = "${aws_iam_policy.manage_own_iam.arn}"
}

module "group_fake1" {
  source      = "../modules/groups"
  group_name  = "fake1"
  policy_arn = "${aws_iam_policy.manage_own_iam.arn}"
}
