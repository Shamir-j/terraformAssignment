resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}



# resource "aws_instance" "role-test" {
#   ami                  = "ami-0bbe6b35405ecebdb"
#   instance_type        = "t2.micro"
#   iam_instance_profile = aws_iam_instance_profile.test_profile.name
#   key_name             = "mytestpubkey"
# }
resource "aws_instance" "instance" {
  count           = length(aws_subnet.public_subnet.*.id)
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = element(aws_subnet.public_subnet.*.id, count.index)
  security_groups = [aws_security_group.sg.id, ]
  key_name        = aws_key_pair.generated_key.key_name
  # iam_instance_profile = aws_iam_policy.ec2_full.name
  # iam_instance_profile = aws_iam_instance_profile.test_profile.name
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  user_data            = <<-EOF
                    #!/bin/bash
                    sudo yum update -y
                    sudo yum install nginx -y 
                    sudo service start nginx
                EOF

  tags = {
    "Name"        = "Instance-${count.index}"
    "Environment" = "Test"
    "CreatedBy"   = "Terraform"
  }

  timeouts {
    create = "10m"
  }

}

# resource "null_resource" "null" {
#   count = length(aws_subnet.public_subnet.*.id)

#   provisioner "file" {
#     source      = "./userdata.sh"
#     destination = "/home/ec2-user/userdata.sh"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /home/ec2-user/userdata.sh",
#       "sh /home/ec2-user/userdata.sh",
#     ]
#     on_failure = continue
#   }

#   connection {
#     type        = "ssh"
#     user        = "ec2-user"
#     port        = "22"
#     host        = element(aws_eip.eip.*.public_ip, count.index)
#     private_key = file(var.ssh_private_key)
#   }

# }

resource "aws_eip" "eip" {
  count            = length(aws_instance.instance.*.id)
  instance         = element(aws_instance.instance.*.id, count.index)
  public_ipv4_pool = "amazon"
  vpc              = true

  tags = {
    "Name" = "EIP-${count.index}"
  }
}

resource "aws_eip_association" "eip_association" {
  count         = length(aws_eip.eip)
  instance_id   = element(aws_instance.instance.*.id, count.index)
  allocation_id = element(aws_eip.eip.*.id, count.index)
}
