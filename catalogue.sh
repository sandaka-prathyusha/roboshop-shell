script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=catalogue

func_nodejs






echo -e "\e[34m>>>>>>>>>Copy MongoDB repos<<<<<<<<<\e[0m"
cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[34m>>>>>>>>>Install Mongo Client<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[34m>>>>>>>>>Load schema<<<<<<<<<\e[0m"
mongo --host mongodb-dev.nandu18.online</app/schema/catalogue.js

