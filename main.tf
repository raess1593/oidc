resource "aws_iam_openid_connect_provider" "github_oidc" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    "1b511abead59c6ce207077c0bf0e0043b1382612",
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
}

resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github_oidc.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
            "token.actions.githubusercontent.com:sub" = [
              "repo:${var.github_repo}:ref:refs/heads/*",
              "repo:${var.github_repo}:ref:refs/tags/*",
              "repo:${var.github_repo}:ref:refs/pull/*",
            ]
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket" "github_actions_bucket-87654323" {
  bucket = "my-github-actions-bucket-87654323"
}

resource "aws_iam_policy" "github_actions_policy" {
  name        = "github-actions-policy"
  description = "Policy for GitHub Actions to access S3 bucket and IAM"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AllowS3Access"
        Effect = "Allow"
        Action = [
          "s3:CreateBucket",
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::my-github-actions-bucket-87654323",
          "arn:aws:s3:::my-github-actions-bucket-87654323/*"
        ]
      }
      {
        Sid = "AllowIAMAccess"
        Effect = "Allow"
        Action = [
          "iam:GetPolicy",
                "iam:CreatePolicy",
                "iam:DeletePolicy",
                "iam:GetPolicyVersion",
                "iam:ListPolicyVersions",
                "iam:CreatePolicyVersion",
                "iam:DeletePolicyVersion",
                "iam:AttachRolePolicy",
                "iam:DetachRolePolicy",
                "iam:ListAttachedRolePolicies"
        ]
        Resource = [
            "*"
        ]
     }
     {
        Sid = "OIDCProviderAccess"
        Effect = "Allow"
        Action = [
            "iam:GetOpenIDConnectProvider",
            "iam:CreateOpenIDConnectProvider",
            "iam:DeleteOpenIDConnectProvider",
            "iam:UpdateOpenIDConnectProviderThumbprint",
            "iam:AddClientIDToOpenIDConnectProvider"
            ]
        Resource = [
            aws_iam_openid_connect_provider.github_oidc.arn
            ]
     }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions_policy_attachment" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.github_actions_policy.arn
}

output "role_arn" {
  value = aws_iam_role.github_actions_role.arn
}