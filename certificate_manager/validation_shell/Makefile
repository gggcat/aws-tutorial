
MY_NAME_IS=go
DELIMITER=-
TASK_NAME=certmanager
STACK_NAME=$(join $(join $(MY_NAME_IS), $(DELIMITER)), $(TASK_NAME))
PARAMETERS_FILE="file://./parameters.json"
TEMPLATE_FILE="file://./certmanager.yml"
CHANGE_SET_NAME=$(join $(join $(STACK_NAME), $(DELIMITER)), $(shell date +'%y%m%d-%H%M%S'))

change-set-list:
	aws cloudformation list-change-sets --stack-name  $(STACK_NAME)
change-set-create:
	aws cloudformation create-change-set --stack-name $(STACK_NAME) --change-set-name $(CHANGE_SET_NAME) --template-body $(TEMPLATE_FILE) --parameters $(PARAMETERS_FILE)

create:
	aws cloudformation create-stack --stack-name $(STACK_NAME) --template-body $(TEMPLATE_FILE) --parameters $(PARAMETERS_FILE) --region us-east-1
update:
	aws cloudformation update-stack --stack-name $(STACK_NAME) --template-body $(TEMPLATE_FILE) --parameters $(PARAMETERS_FILE) --region us-east-1
clean:
	aws cloudformation delete-stack --stack-name $(STACK_NAME) --region us-east-1
describe:
	aws cloudformation describe-stacks --output table --region us-east-1

DomainName=$(shell jq -r '.[] | select (.ParameterKey == "DomainName") | .ParameterValue' parameters.json)

dns-validate:
	bash dns-validation.sh $(DomainName) $(STACK_NAME)