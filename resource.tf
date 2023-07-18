resource "aws_instance" "project" {
  ami  =  "ami-053b0d53c279acc90"       
  instance_type = "t2.medium"
  key_name = "gbkey"
 

  count = 1

  tags = {
    Name = "jenkins${count.index}"
    owner = "dongb"
  }
user_data = <<EOF
#!/bin/bash

sudo apt-get install git wget -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt update -y
sudo apt-get install jenkins -y
sudo apt install openjdk-17-jre -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
curl -fsSL get.docker.com | /bin/bash  
sudo usermod -aG docker jenkins  
sudo systemctl restart jenkins

EOF
  

}

resource "aws_instance" "kube" {
  ami  =  "ami-053b0d53c279acc90"       
  instance_type = "t2.medium"
  key_name = "gbkey"
 
  count = 2

  tags = {
    Name = "kube${count.index}"
    owner = "dongb"

  }
}
#resource "aws_key_pair" "keypair" {

  #key_name =  "keyname"
  #public_key = file("~/.ssh/keyname.pub")



#}
 
