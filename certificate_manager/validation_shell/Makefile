
MY_NAME_IS=tutorial
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
clean: clean-dns-validate
	aws cloudformation delete-stack --stack-name $(STACK_NAME) --region us-east-1
describe:
	aws cloudformation describe-stacks --output table --region us-east-1

DOMAIN_NAME=$(shell jq -r '.[] | select (.ParameterKey == "DomainName") | .ParameterValue' parameters.json)

dns-validate:
	bash dns-validation-add.sh $(DOMAIN_NAME) $(STACK_NAME)

clean-dns-validate:
	bash dns-validation-del.sh $(DOMAIN_NAME) $(STACK_NAME)
	rm -f dns-validation-add.json
	rm -f dns-validation-del.json

certid:
	aws cloudformation describe-stacks --region us-east-1 | jq '.Stacks[].Outputs[] | select( .OutputKey == "MyZoneCertificateID" ) | .OutputValue'

hosted-zone-id:
	$(shell aws route53 list-hosted-zones | jq -r '.HostedZones[] | select (.Name == "$(DOMAIN_NAME).") | .Id')