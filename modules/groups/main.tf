resource "aws_iam_group" "group" {
  name = "${var.group_name}"
}

resource "aws_iam_group_policy_attachment" "policy_attachment" {
  group      = "${var.group_name}"
  policy_arn = "${var.policy_arn}"
}
