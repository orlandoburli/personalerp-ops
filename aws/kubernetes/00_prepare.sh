# Instala o AWS Cli
pip3 install awscli --upgrade --user

# Instala o EKS Control
brew tap weaveworks/tap

brew install weaveworks/tap/eksctl

# Instala o JSon Query
brew install jq

# Instala o Helm Cli
curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

helm repo update
