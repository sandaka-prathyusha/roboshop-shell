script=$(realpath "$0")
script_path=$(dirname "script ")
source ${script_path}/common.sh

"\e[34m>>>>>>>>>copying mongo repos<<<<<<<<<\e[0m"
cp mongo.repo  /etc/yum.repos.d/mongo.repo

"\e[34m>>>>>>>>> Installing mongodb<<<<<<<<<\e[0m"
yum install mongodb-org -y

"\e[34m>>>>>>>>>changing listen address<<<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

"\e[34m>>>>>>>>>Starting mongodb<<<<<<<<<\e[0m"
systemctl enable mongod
systemctl restart mongod


