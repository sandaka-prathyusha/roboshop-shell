 app_user=roboshop
 script=$(realpath "$0")
 script_path=$(dirname "$script")

 func_print_head(){
  echo -e "\e[33m>>>>>>>>> $1 <<<<<<<<<\e[0m"
 }

 func_schema_setup() {
   if [ "$schema_setup" == "mongo"]; then
     func_print_head "INSTALL MONGODB REPO"
     cp ${script_path}/mongo.repo  /etc/yum.repos.d/mongo.repo

     func_print_head "INSTALL MONGODB CLIENT"
     yum install mongodb-org-shell -y
     func_print_head "LOAD SCHEMA"
     mongo --host mongodb-dev.nandu18.online  </app/schema/${component}.js
   fi
   if [ "$schema_setup" == "mysql"]; then

     func_print_head  "INSTALL MYSQL Client"
     yum install mysql -y

     func_print_head  "LOAD SCHEMA"
     mysql -h  mysql-dev.nandu18.online -uroot -p${mysql_root_passwrd} <  /app/schema/shipping.sql
   fi

 }


 func_app_prereq() {

     func_print_head  "Adding Application User"
     useradd ${app_user}

     func_print_head  "Create Application Directory"
     rm -rf /app
     mkdir /app

     func_print_head "Downloading Application Content"
     curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
     cd /app

     func_print_head "Unzip Application content"
     unzip /tmp/${component}.zip
    }

func_systemd_setup() {
     func_print_head "Setup SystemD file"
     cp  ${script_path}/${component}.service  /etc/systemd/system/${component}.service

     func_print_head "Start ${component} service"
     systemctl daemon-reload
     systemctl enable ${component}
     systemctl restart ${component}
    }

 func_nodejs() {

    func_print_head "configuring NodeJS"
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash

    func_print_head "Install NodeJS"
    yum install nodejs -y

    func_app_prereq

    func_print_head "Install NodeJS Dependencies"
    npm install

    func_schema_setup
    func_systemd_setup
   }

func_java() {

  func_print_head "Install Maven"
  yum install maven -y

  func_app_prereq

  func_print_head "Downloading Maven Dependencies"
  mvn clean package

  func_print_head  "Move the file"
  mv target/${component}-1.0.jar   ${component}.jar

  func_schema_setup
  func_systemd_setup
}
  }