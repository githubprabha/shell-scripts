#!/bin/bash

USER=$(id -u)

LOG=jenkin-install.log

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 is ${RED}failed${NC}"
        exit 1
    else
        echo -e "$2 is ${GREEN}success${NC}"
    fi
}
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
# RED="\e[31m"
# Green="\e[32m"
# NC="\e[0m"

if [ $USER -ne 0 ]; then
    echo -e "You must be ${RED}root${NC} to run this script"
    exit 1
fi

JAVA=${java--verision}

VALIDATE $? "java version"

apt-get update -y  >> $LOG

VALIDATE $? "updating  apt-get"

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key  >> $LOG

VALIDATE $? "jenkins key setup"

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list >/dev/null  

VALIDATE $? "jenkins env setup"

apt-get install jenkins -y  >> $LOG

VALIDATE $? "install jenkins"

systemctl enable jenkins  >> $LOG

VALIDATE $? "enable jenkins"

systemctl start jenkins  >> $LOG

VALIDATE $? "start jenkins"
