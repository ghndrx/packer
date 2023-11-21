packer {
     required_version = ">= 1.6.6"
 }
 
source "amazon-ebs" "ubuntu" {
    ami_name      = "test-custom-ubuntu20.04-ami-{{timestamp}}"
    instance_type = "t2.micro"
    region        = "us-west-1"
    ssh_username  = "ubuntu"
    # 20.04 "ami-0da7657fe73215c0c"
    source_ami    = "ami-0da7657fe73215c0c"
    temporary_key_pair_name = "packer_ubuntu"
    temporary_key_pair_type = "rsa"
    
}
  
build {
    name    = "ubuntu-ami"
    sources = ["source.amazon-ebs.ubuntu"]
  
    provisioner "shell" {
        inline = [
            "sleep 30",
            "sudo apt-get update",
            "sudo apt-get install -y nginx",
            "sudo service nginx start"
        ]
    }
 
}