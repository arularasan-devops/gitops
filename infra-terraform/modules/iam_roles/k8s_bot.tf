resource "aws_s3_bucket" "bot_s3_bucket" {
  bucket = "celigo-k8s-${var.env}-env-vars"
      
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryp" {
  bucket = aws_s3_bucket.bot_s3_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_iam_policy" "bot_s3_access_Policy" {
    name = "k8s-bot-s3-access"
    path = "/"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::celigo-k8s-${var.env}-env-vars/*",
                "arn:aws:s3:::celigo-k8s-${var.env}-env-vars"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::${var.s3_metadata_bucket_name}/*",
                "arn:aws:s3:::${var.s3_debug_bucket_name}/*",
                "arn:aws:s3:::${var.s3_metadata_bucket_name}",
                "arn:aws:s3:::${var.s3_debug_bucket_name}"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_user" "bot_user" {
    path = "/"
    name = "k8s-bot"
   
}

resource "aws_iam_user_policy_attachment" "policy_attachment" {
  user       = aws_iam_user.bot_user.name
  policy_arn = aws_iam_policy.bot_s3_access_Policy.arn
}


