echo -e "\e[36m>>>>>>>>>Java Installation <<<<<<<<<\e[0m"
yum install maven -y

echo -e "\e[36m>>>>>>>>>Adding Application User <<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>>Create Application Directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>>Downloading Application Content <<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app

echo -e "\e[36m>>>>>>>>>Unzip Application content<<<<<<<<<\e[0m"
unzip /tmp/shipping.zip
cd /app

echo -e "\e[36m>>>>>>>>> Downloading Dependencies <<<<<<<<<\e[0m"
mvn clean package


echo -e "\e[36m>>>>>>>>>move the file<<<<<<<<<\e[0m"
mv target/shipping-1.0.jar  shipping.jar


echo -e "\e[36m>>>>>>>>>Coping systemd service file<<<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/shipping.service  /etc/systemd/system/shipping.service

echo -e "\e[36m>>>>>>>>>START SHIPPING<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping


echo -e "\e[36m>>>>>>>>>INSTALL MYSQL <<<<<<<<<\e[0m"
yum install mysql -y


echo -e "\e[36m>>>>>>>>>LOAD SCHEMA <<<<<<<<<\e[0m"
mysql -h  mysql-dev.nandu18.online -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[36m>>>>>>>>>RESTART SHIPPING <<<<<<<<<\e[0m"
systemctl restart shipping