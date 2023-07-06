script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh


func_print_head "Install Nginx"
yum install nginx -y &>>$log_file
func_stat_check $?


func_print_head "COPY ROBOSHOP CONF"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf  &>>$log_file
func_stat_check $?


func_print_head "REMOVING OLD CONTENT"
rm -rf /usr/share/nginx/html/* &>>$log_file
func_stat_check $?

func_print_head "Dowloading FRONTEND"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
func_stat_check $?


func_print_head "UNZIP FRONTEND CONTENT "
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file
func_stat_check $?


func_print_head "STARTING Nginx"
systemctl enable nginx &>>$log_file
func_stat_check $?
systemctl restart nginx &>>$log_file
func_stat_check $?

