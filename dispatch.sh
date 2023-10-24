script=$(realpath "$0")
script_path=$(dirname "$script")
source common.sh

"\e[34m>>>>>>>>> Installing golang <<<<<<<<<\e[0m"
yum install golang -y

"\e[34m>>>>>>>>>Adding App user<<<<<<<<<\e[0m"
useradd ${app_user}

"\e[34m>>>>>>>>>Removing previous content<<<<<<<<<\e[0m"
rm -rf /app

"\e[34m>>>>>>>>>creating application directory<<<<<<<<<\e[0m"
mkdir /app

"\e[34m>>>>>>>>>Downloading Application Content<<<<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app

"\e[34m>>>>>>>>>Unzip app content<<<<<<<<<\e[0m"
unzip /tmp/dispatch.zip
cd /app

"\e[34m>>>>>>>>>Downloading the Dependencies  <<<<<<<<<\e[0m"
go mod init dispatch
go get
go build


"\e[34m>>>>>>>>>copy systemd service<<<<<<<<<\e[0m"
cp ${scrit_path}/dispatch.service  /etc/systemd/system/dispatch.service

"\e[34m>>>>>>>>>starting dispatch service<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch