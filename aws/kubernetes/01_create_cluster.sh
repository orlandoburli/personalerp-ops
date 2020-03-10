# Create clusters
export AWS_DEFAULT_PROFILE=personalerp

eksctl create cluster --name personalerp-cluster-stg --nodes 4 --region us-east-1
