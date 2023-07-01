script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

echo -e "\e[34m>>>>>>>>>Install Nginx <<<<<<<<<\e[0m"
yum install nginx -y

echo -e "\e[34m>>>>>>>>>COPY ROBOSHOP CONF <<<<<<<<<\e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[34m>>>>>>>>>REMOVING OLD CONTENT<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[34m>>>>>>>>>Dowloading FRONTEND<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[34m>>>>>>>>>UNZIP FRONTEND CONTENT <<<<<<<<<\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[34m>>>>>>>>>STARTING Nginx<<<<<<<<<\e[0m"
systemctl enable nginx
systemctl restart nginx

