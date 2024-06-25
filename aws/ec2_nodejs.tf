# ----------------------------------------------------------------
# EC2 Instance
# ----------------------------------------------------------------

resource "random_integer" "az_index_nodejs" {
  min = 0
  max = length(data.aws_availability_zones.available.names) - 1
}

resource "aws_instance" "nodejs" {
  ami                    = data.aws_ami.ubuntu_focal.id
  instance_type          = "t3.small"
  key_name               = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [
    aws_security_group.public_base_sg.id,
    aws_security_group.private_base_sg.id,
    aws_security_group.public_nodejs_sg.id,
  ]
  subnet_id              = aws_subnet.public_subnet[data.aws_availability_zones.available.names[random_integer.az_index_nodejs.result]].id
  user_data              = <<-EOF
    #! /bin/bash
    # Set hostname
    hostnamectl set-hostname ${var.prefix}-nodejs

    # Install node and npm
    # https://qiita.com/seibe/items/36cef7df85fe2cefa3ea
    apt update
    apt install -y nodejs npm
    npm install n -g
    # Install latest node and remove the old one
    n stable
    apt purge -y nodejs npm
    su - ubuntu -c "exec $SHELL -l"
  EOF

  root_block_device {
    # For reference: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html
    volume_size = 8
  }

  tags = {
    Name = "${var.prefix}-nodejs"
  }

  volume_tags = {
    Name = "${var.prefix}-nodejs"
  }

  lifecycle {
    ignore_changes = [ user_data, ami ]
  }
}

# ----------------------------------------------------------------
# Outputs
# ----------------------------------------------------------------

output "ec2_nodejs_public_ip" {
  value = aws_instance.nodejs.public_ip
}
