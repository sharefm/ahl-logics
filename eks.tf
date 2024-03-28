resource "aws_iam_role" "ahl-cluster" {
  name = "ahl-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "ahl-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.ahl-cluster.id
}

resource "aws_eks_cluster" "ahl-cluster" {
  name     = "ahl-cluster"
  role_arn = aws_iam_role.ahl-cluster.arn
  enabled_cluster_log_types = ["audit", "api", "authenticator","scheduler"]

  vpc_config {
    subnet_ids = [
      aws_subnet.private-a.id,
      aws_subnet.private-b.id,
      aws_subnet.public-a.id,
      aws_subnet.public-b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment  .ahl-cluster-AmazonEKSClusterPolicy]
}
