# resource "aws_iam_user" "newusers" {
#   #   count = length(var.username)
#   #   name  = element(var.username, count.index)
#   name  = var.username
# }

# resource "aws_iam_user_policy_attachment" "ec2-user-full" {
#   # count = length(var.username)
#   #   user       = element(aws_iam_user.newusers.*.name, count.index)
#   user       = aws_iam_user.newusers.name
#   policy_arn = aws_iam_policy.ec2_full.arn
# }


# resource "aws_iam_policy_attachment" "test-attach" {
#   name       = "test-attachment"
#   roles      = ["${aws_iam_role.ec2_s3_access_role.name}"]
#   policy_arn = "${aws_iam_policy.policy.arn}"
# }

# resource "aws_iam_role" "ec2_s3_access_role" {
#   name               = "s3-role"
#   assume_role_policy = "${file("assumerolepolicy.json")}"
# }

# resource "aws_iam_policy" "policy" {
#   name        = "test-policy"
#   description = "A test policy"
#   policy      = "${file("policys3bucket.json")}"
# }

# resource "aws_iam_policy_attachment" "test-attach" {
#   name       = "test-attachment"
#   roles      = ["${aws_iam_role.ec2_s3_access_role.name}"]
#   policy_arn = "${aws_iam_policy.policy.arn}"
# }

# resource "aws_iam_instance_profile" "test_profile" {
#   name  = "test_profile"
#   role = "${aws_iam_role.ec2_s3_access_role.name}"
# }