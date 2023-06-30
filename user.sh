script_path=$(dirname $0)

source ${script_path}/common.sh

echo -e "\e[34m>>>>>>>>>Dowloading NodeJS Repos <<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash


echo -e "\e[34m>>>>>>>>> Installing NodeJS <<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[34m>>>>>>>>>Adding Application User<<<<<<<<<\e[0m"
useradd ${app_user}

rm -rf  /app
mkdir /app

echo -e "\e[34m>>>>>>>>>Download Application Content<<<<<<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[34m>>>>>>>>Unzip App Content<<<<<<<<<<<\e[0m"
unzip /tmp/user.zip
cd /app

echo -e "\e[34m>>>>>>>>>Install NodeJS Dependencies<<<<<<<<<\e[0m"
npm install


echo -e "\e[34m>>>>>>>>>Copy user SystemD file<<<<<<<<<\e[0m"
cp $script_path/user.service  /etc/systemd/system/user.service
systemctl daemon-reload


echo -e "\e[34m>>>>>>>>>Starting user Service<<<<<<<<<\e[0m"
systemctl enable user
systemctl restart user

echo -e "\e[34m>>>>>>>>>Copy MongoDB repos<<<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/mongo.repo  /etc/yum.repos.d/mongo.repo

echo -e "\e[34m>>>>>>>>>Install Mongo Client<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[34m>>>>>>Load Schema<<<<<<<<<\e[0m"
mongo --host mongodb-dev.nandu18.online  </app/schema/user.js

