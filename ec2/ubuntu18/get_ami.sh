
VERSION=$1

UBUNTU_AMI=$(aws ec2 describe-images --owners 099720109477 --filters "Name=name,Values=ubuntu/images/hvm-ssd/*${VERSION}*" "Name=architecture,Values=x86_64" --query 'reverse(sort_by(Images, &CreationDate))[0].ImageId' --region ap-northeast-1)

cat > parameters.json <<EOL
[
    {
        "ParameterKey": "KeyName",
        "ParameterValue": "mykey"
    },
    {
        "ParameterKey": "ImageID",
        "ParameterValue": ${UBUNTU_AMI}
    },
    {
        "ParameterKey": "AllowSshFrom",
        "ParameterValue": "0.0.0.0/0"
    }
]
EOL