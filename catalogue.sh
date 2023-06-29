echo -e "\e[34m>>>>>>>>>configuring NodeJS<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[34m>>>>>>>>>Install NodeJS<<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[34m>>>>>>>>>Add Application user<<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[34m>>>>>>>>>Create Application Directory<<<<<<<<<\e[0m"
mkdir /app
echo -e "\e[34m>>>>>>>>>Download App Content <<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "\e[34m>>>>>>>>>Unzip App Content<<<<<<<<<\e[0m"
unzip /tmp/catalogue.zip
cd /app
echo -e "\e[34m>>>>>>>>>Install NodeJS Dependencies<<<<<<<<<\e[0m"
npm install
echo -e "\e[34m>>>>>>>>>Copy Catalogue SystemD file<<<<<<<<<\e[0m"
cp catalogue.service  /etc/systemd/system/catalogue.service
echo -e "\e[34m>>>>>>>>>Start Catalogue service<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
echo -e "\e[34m>>>>>>>>>Copy MongoDB repos<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[34m>>>>>>>>>Install Mongo Client<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[34m>>>>>>>>>Load schema<<<<<<<<<\e[0m"
mongo --host mongodb-dev.nandu18.online</app/schema/catalogue.js

