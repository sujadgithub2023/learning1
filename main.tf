resource "aws_instance" "instance" {
  ami           = var.ec2_details.ec2_ami
  instance_type = var.ec2_details.instance_name
  key_name = aws_key_pair.deployer.key_name
}

resource "aws_key_pair" "deployer" {
  key_name   =  var.ec2_details.key_pair_name
  public_key = tls_private_key.rsa-4096-example.public_key_openssh
}

resource "tls_private_key" "rsa-4096-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "foo"{
  content = tls_private_key.rsa-4096-example.private_key_pem
  filename = "demo_check.pem"
}

output "aws_instance"{
  value=aws_instance.instance
}

provider "aws" {
  region = "ap-south-1"
}
variable "ec2_details" {
    type = object({
        ec2_ami = string
        instance_name= string
        key_pair_name=string
    })
    default ={
        ec2_ami  = "ami-0376ec8eacdf70aae" 
        instance_name= "t2.nano"
        key_pair_name="shaheda_check4859"
    }
}

