resource "aws_iam_user" "user" {
  name = "${var.name}"
}

resource "aws_iam_user_group_membership" "group_membership" {
  user = "${var.name}"

  groups = [
    "${var.groups}"
  ]
}
