
MY_NAME_IS=tutorial
DELIMITER=-
TASK_NAME=ec2
STACK_NAME=$(join $(join $(MY_NAME_IS), $(DELIMITER)), $(TASK_NAME))
PARAMETERS_FILE="file://./parameters.json"
TEMPLATE_FILE="file://./ec2.yml"
CHANGE_SET_NAME=$(join $(join $(STACK_NAME), $(DELIMITER)), $(shell date +'%y%m%d-%H%M%S'))

change-set-list:
	aws cloudformation list-change-sets --stack-name  $(STACK_NAME)
change-set-create:
	aws cloudformation create-change-set --stack-name $(STACK_NAME) --change-set-name $(CHANGE_SET_NAME) --template-body $(TEMPLATE_FILE) --parameters $(PARAMETERS_FILE)

create:
	aws cloudformation create-stack --stack-name $(STACK_NAME) --template-body $(TEMPLATE_FILE) --parameters $(PARAMETERS_FILE)
update:
	aws cloudformation update-stack --stack-name $(STACK_NAME) --template-body $(TEMPLATE_FILE) --parameters $(PARAMETERS_FILE)
clean:
	aws cloudformation delete-stack --stack-name $(STACK_NAME)
describe:
	aws cloudformation describe-stacks --output table

ami:
	bash get_ami.sh 18.04