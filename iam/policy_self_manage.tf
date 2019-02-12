resource "aws_iam_policy" "manage_own_iam" {
  name = "ManageOwnIAM"
  description = "Allows users to manage their own account and nothing else until MFAd"
  policy = <<EOF
{    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowAllUsersToListAccounts",
            "Effect": "Allow",
            "Action": [
                "iam:ListAccountAliases",
                "iam:ListUsers"
            ],
            "Resource": [
                "arn:aws:iam::450047772925:user/*"
            ]
        },
        {
            "Sid": "AllowIndividualUserToSeeTheirAccountInformation",
            "Effect": "Allow",
            "Action": [
                "iam:ChangePassword",
                "iam:CreateLoginProfile",
                "iam:DeleteLoginProfile",
                "iam:GetAccountPasswordPolicy",
                "iam:GetAccountSummary",
                "iam:GetLoginProfile",
                "iam:UpdateLoginProfile",
                "iam:GetUser",
                "iam:*AccessKey*"
            ],
            "Resource": [
                "arn:aws:iam::450047772925:user/$${aws:username}"
            ]
        },
        {
            "Sid": "AllowIndividualUserToListTheirMFA",
            "Effect": "Allow",
            "Action": [
                "iam:ListVirtualMFADevices",
                "iam:ListMFADevices"
            ],
            "Resource": [
                "arn:aws:iam::450047772925:mfa/*",
                "arn:aws:iam::450047772925:user/$${aws:username}"
            ]
        },
        {
            "Sid": "AllowIndividualUserToManageThierMFA",
            "Effect": "Allow",
            "Action": [
                "iam:CreateVirtualMFADevice",
                "iam:DeactivateMFADevice",
                "iam:DeleteVirtualMFADevice",
                "iam:EnableMFADevice",
                "iam:ResyncMFADevice"
            ],
            "Resource": [
                "arn:aws:iam::450047772925:mfa/$${aws:username}",
                "arn:aws:iam::450047772925:user/$${aws:username}"
            ]
        }
    ]
}
EOF
}
