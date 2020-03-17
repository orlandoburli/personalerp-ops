export AWS_DEFAULT_PROFILE=personalerp

# Cria o Secret para que o kubernetes possa acessar o repositório privado do Docker Hub
kubectl create secret docker-registry personalerp-dockerhub-secret \
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=$1 \
    --docker-password=$2 \
    --docker-email=$3
