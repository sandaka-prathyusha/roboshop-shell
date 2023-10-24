script=$(realpath "$0")
script_path=$(dirname "$script")
source common.sh
rabbitmq_appuser_password=$1 
#${script_path}/
if [ -z "$rabbitmq_appuser_password" ]; then
   echo input Roboshop Appuser Password Missing
   exit 1
fi

func_print_head "Download rabbitmq repos "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$log_file
func_stat_check $?

func_print_head "configuring rabbitmq repo"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$log_file
func_stat_check $?

func_print_head "Rabbitmq Installation "
yum install  erlang rabbitmq-server -y &>>$log_file
func_stat_check $?

func_print_head "starting rabbitmq"
systemctl enable rabbitmq-server &>>$log_file
systemctl restart rabbitmq-server &>>$log_file
func_stat_check $?

func_print_head  "Adding application user"
rabbitmqctl add_user roboshop ${rabbitmq_appuser_password} &>>$log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file
func_stat_check $?