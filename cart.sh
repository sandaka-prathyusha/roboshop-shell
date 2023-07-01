script=$(realpath "$0")
script_path=$(dirname "script")
source ${script_path}/common.sh

echo -e "\e[34m>>>>>>>>>configuring NodeJS<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[34m>>>>>>>>>Install NodeJS<<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[34m>>>>>>>>>Add Application user<<<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[34m>>>>>>>>>Create Application Directory<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app


echo -e "\e[34m>>>>>>>>>Download App Content <<<<<<<<<\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app

echo -e "\e[34m>>>>>>>>>Unzip App Content<<<<<<<<<\e[0m"
unzip /tmp/cart.zip
cd /app

echo -e "\e[34m>>>>>>>>>Install NodeJS Dependencies<<<<<<<<<\e[0m"
npm install

echo -e "\e[34m>>>>>>>>>Copy Cart SystemD file<<<<<<<<<\e[0m"
cp  $script_path/cart.service  /etc/systemd/system/cart.service

echo -e "\e[34m>>>>>>>>>Start Cart service<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart

