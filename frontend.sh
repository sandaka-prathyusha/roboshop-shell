script=$(realpath "$0")
script_path=$(dirname "script ")
source ${script_path}/common.sh

"\e[34m>>>>>>>>> Installing Nginx<<<<<<<<<\e[0m"
yum install nginx -y

"\e[34m>>>>>>>>>copy roboshop config <<<<<<<<<\e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf

"\e[34m>>>>>>>>>remove previous app content<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*

"\e[34m>>>>>>>>Downloading frontend content <<<<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

"\e[34m>>>>>>>>>extract frontend content <<<<<<<<<\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

"\e[34m>>>>>>>>>Starting  Nginx<<<<<<<<<\e[0m"
systemctl enable nginx
systemctl restart nginx

