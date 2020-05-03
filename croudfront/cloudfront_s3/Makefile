
MY_NAME_IS=tutorial
DELIMITER=-
TASK_NAME=cloudfront-s3
STACK_NAME=$(join $(join $(MY_NAME_IS), $(DELIMITER)), $(TASK_NAME))
PARAMETERS_FILE="file://./parameters.json"
TEMPLATE_FILE="file://./cloudfront_s3.yml"
CHANGE_SET_NAME=$(join $(join $(STACK_NAME), $(DELIMITER)), $(shell date +'%y%m%d-%H%M%S'))

change-set-list:
	aws cloudformation list-change-sets --stack-name  $(STACK_NAME)
change-set-create:
	aws cloudformation create-change-set --stack-name $(STACK_NAME) --change-set-name $(CHANGE_SET_NAME) --template-body $(TEMPLATE_FILE) --parameters $(PARAMETERS_FILE)

create:
	aws cloudformation create-stack --stack-name $(STACK_NAME) --template-body $(TEMPLATE_FILE) --parameters $(PARAMETERS_FILE)
update:
	aws cloudformation update-stack --stack-name $(STACK_NAME) --template-body $(TEMPLATE_FILE) --parameters $(PARAMETERS_FILE)
clean: clean-contents
	aws cloudformation delete-stack --stack-name $(STACK_NAME)
describe:
	aws cloudformation describe-stacks --output table

BUCKET_NAME=$(shell jq -r '.[] | select (.ParameterKey == "S3BucketName") | .ParameterValue' parameters.json)
LOG_PREFIX=log.
LOG_BUCKET_NAME=$(join $(LOG_PREFIX), $(BUCKET_NAME))

deploy-contents:
	aws s3 cp contents/index.html s3://$(BUCKET_NAME)/
	aws s3 cp contents/error.html s3://$(BUCKET_NAME)/

clean-contents:
	aws s3 rm s3://$(BUCKET_NAME)/ --recursive
	aws s3 rm s3://$(LOG_BUCKET_NAME)/ --recursive
