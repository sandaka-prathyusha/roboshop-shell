script=$(realpath "$0")
script_path=$(dirname "$script")
source common.sh
rabbitmq_appuser_password=$1

if [ -z "$rabbitmq_appuser_password"  ] ; then
   echo input Roboshop Appuser Password Missing
   exit 1
fi

component=payment
func_python

