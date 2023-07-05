 app_user=roboshop
 script=$(realpath "$0")
 script_path=$(dirname "$script")

 print_head(){
  echo -e "\e[33m>>>>>>>>> $1 <<<<<<<<<\e[0m"
 }


 func_nodejs() {

 print_head "configuring NodeJS"
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash

 print_head "Install NodeJS"
 yum install nodejs -y

 print_head "Add Application user"
 useradd ${app_user}

 print_head "Create Application Directory"
 rm -rf /app
 mkdir /app


 print_head "Download App Content"
 curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
 cd /app

 print_head "Unzip App Content"
 unzip /tmp/${component}.zip
 cd /app

 print_head "Install NodeJS Dependencies"
 npm install

 print_head "Copy Cart SystemD file"
 cp  ${script_path}/${component}.service  /etc/systemd/system/${component}.service

 print_head "Start Cart service"
 systemctl daemon-reload
 systemctl enable ${component}
 systemctl restart ${component}
 }
