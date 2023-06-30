source common.sh
echo -e "\e[36m>>>>>>>>>Install python 3.6<<<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m>>>>>>>>>adding application user <<<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[36m>>>>>>>>>create application directory<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app


echo -e "\e[36m>>>>>>>>>download application content<<<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app


echo -e "\e[36m>>>>>>>>>unzip application content<<<<<<<<<\e[0m"
unzip /tmp/payment.zip
cd /app

echo -e "\e[36m>>>>>>>>>Download Dependencies<<<<<<<<<\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[36m>>>>>>>>>coping systemd file<<<<<<<<<\e[0m"
cp  /home/centos/roboshop-shell/payment.service   /etc/systemd/system/payment.service

echo -e "\e[36m>>>>>>>>>starting payment service<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment