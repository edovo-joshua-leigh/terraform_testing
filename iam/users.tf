resource "aws_iam_user" "nobody" {
  name = "nobody"
}

resource "aws_iam_user_group_membership" "nobody_devel" {
  user = "${aws_iam_user.nobody.name}"
  groups = [
    "${aws_iam_group.developers.name}"
  ]
}

module "fakeuser1" {
  source  = "../modules/users"
  name    = "fakeuser1"
  groups  = "${module.group_fake1.name}"
}
