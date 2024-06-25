# ----------------------------------------------------------------
# Keypair
# ----------------------------------------------------------------

locals {
  public_key_file  = "${var.key_file_path}/${var.key_name}.id_rsa.pub"
  private_key_file = "${var.key_file_path}/${var.key_name}.id_rsa.pem"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  filename = "${local.private_key_file}"
  content  = "${tls_private_key.private_key.private_key_pem}"

  provisioner "local-exec" {
    command = "chmod 600 ${local.private_key_file}"
  }
}

resource "local_file" "public_key_openssh" {
  filename = "${local.public_key_file}"
  content  = "${tls_private_key.private_key.public_key_openssh}"

  provisioner "local-exec" {
    command = "chmod 600 ${local.public_key_file}"
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "${var.prefix}-key"
  public_key = tls_private_key.private_key.public_key_openssh
}

# ----------------------------------------------------------------
# Keypair for Windows
# ----------------------------------------------------------------

locals {
  windows_public_key_file  = "${var.key_file_path}/windows/${var.key_name}_windows.id_rsa.pub"
  windows_private_key_file = "${var.key_file_path}/windows/${var.key_name}_windows.id_rsa.pem"
}

resource "tls_private_key" "windows_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "windows_private_key_pem" {
  filename = "${local.windows_private_key_file}"
  content  = "${tls_private_key.windows_private_key.private_key_pem}"

  provisioner "local-exec" {
    command = "chmod 600 ${local.windows_private_key_file}"
  }
}

resource "local_file" "windows_public_key_openssh" {
  filename = "${local.windows_public_key_file}"
  content  = "${tls_private_key.windows_private_key.public_key_openssh}"

  provisioner "local-exec" {
    command = "chmod 600 ${local.windows_public_key_file}"
  }
}

resource "aws_key_pair" "windows_keypair" {
  key_name   = "${var.prefix}-windows-key"
  #public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
  public_key = tls_private_key.windows_private_key.public_key_openssh
}

