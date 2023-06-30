echo -e "\e[36m>>>>>>>>>Disabling Default MYSQL <<<<<<<<<\e[0m"
dnf module disable mysql -y



echo -e "\e[36m>>>>>>>>>COPYING MYSQL Repos<<<<<<<<<\e[0m"
cp mysql.repo  /etc/yum.repos.d/mysql.repo


echo -e "\e[36m>>>>>>>>>Install MYSQL <<<<<<<<<\e[0m"
yum install mysql-community-server -y


echo -e "\e[36m>>>>>>>>>Starting mysql<<<<<<<<<\e[0m"
systemctl enable mysqld
systemctl restart mysqld


echo -e "\e[36m>>>>>>>>>Changing root password<<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
