script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
${mysql_root_password}

echo -e "\e[36m>>>>>>>>>Disabling Default mysql<<<<<<<<<\e[0m"
dnf module disable mysql -y

echo -e "\e[36m>>>>>>>>>COPYING MYSQL Repos<<<<<<<<<\e[0m"
cp mysql.repo  /etc/yum.repos.d/mysql.repo

echo -e "\e[36m>>>>>>>>>Install mysql<<<<<<<<<\e[0m"
yum install mysql-community-server -y

echo -e "\e[36m>>>>>>>>>Starting mysql<<<<<<<<<\e[0m"
systemctl enable mysqld
systemctl restart mysqld

echo -e "\e[36m>>>>>>>>>Changing root password<<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass ${mysql_root_password}
