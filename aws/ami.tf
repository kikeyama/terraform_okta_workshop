# ----------------------------------------------------------------
# Ubuntu 20.04
# ----------------------------------------------------------------

data "aws_ami" "ubuntu_focal" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230811"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ----------------------------------------------------------------
# Windows Server 2022
# ----------------------------------------------------------------

data "aws_ami" "windows_2022" {
  owners      = ["801119661308"]
  most_recent = true
  name_regex  = "^Windows_Server-2022-English-Full-Base-[^$]+$"
}

output "ami_windows_2022_image_id" {
  value = data.aws_ami.windows_2022.image_id
}

output "ami_windows_2022_name" {
  value = data.aws_ami.windows_2022.name
}
