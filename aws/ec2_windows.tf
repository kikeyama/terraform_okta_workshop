# ----------------------------------------------------------------
# EC2 Instance
# ----------------------------------------------------------------

resource "random_integer" "az_index_windows" {
  min = 0
  max = length(data.aws_availability_zones.available.names) - 1
}

resource "aws_instance" "windows" {
  ami                    = data.aws_ami.windows_2022.id
  instance_type          = "t3.small"
  key_name               = aws_key_pair.windows_keypair.key_name
  vpc_security_group_ids = [
    aws_security_group.public_base_sg.id,
    aws_security_group.private_base_sg.id,
    aws_security_group.public_windows_sg.id,
  ]
  subnet_id              = aws_subnet.public_subnet[data.aws_availability_zones.available.names[random_integer.az_index_windows.result]].id

  root_block_device {
    # For reference: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = "${var.prefix}-windows"
  }

  volume_tags = {
    Name = "${var.prefix}-windows"
  }

  lifecycle {
    ignore_changes = [ ami ]
  }
}

# ----------------------------------------------------------------
# Outputs
# ----------------------------------------------------------------

output "ec2_windows_public_ip" {
  value = aws_instance.windows.public_ip
}
