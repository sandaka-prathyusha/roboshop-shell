script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh


echo -e "\e[34m>>>>>>>>>copy mongo repos<<<<<<<<<\e[0m"
cp mongo.repo  /etc/yum.repos.d/mongo.repo


echo -e "\e[34m>>>>>>>>>Install mongodb <<<<<<<<<\e[0m"
yum install mongodb-org -y

echo -e "\e[34m>>>>>>>>>changing bind address<<<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

echo -e "\e[34m>>>>>>>>>starting mongodb<<<<<<<<<\e[0m"
systemctl enable mongod
systemctl restart mongod


