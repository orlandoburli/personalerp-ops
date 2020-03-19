# Projeto Personal ERP

## Scripts de criação de ambientes

## Descrição das pastas

* **terraform** - Todos os scripts de terraform ficarão nesta pasta, separados por ambiente.

  * **terraform\prd** - Aqui ficam os scripts de incialização do ambiente de ***produção***. Irá importar os módulos que são compartilhados entre os ambientes.

  * **terraform\stg** - Aqui ficam os scripts de incialização do ambiente de ***stage***. Irá importar os módulos que são compartilhados entre os ambientes.

  * **terraform\modules** - Aqui ficam os módulos do projeto.

    * **terraform\modules\network** - Criação da infraestrutura básica de rede (VPC, subnets, route tables).

    * **terraform\modules\cluster** - Criação do cluster e suas roles

    * **terraform\modules\worknodes** - Criação dos worknodes.
  
* **aws** - Shell scripts para deploy das aplicações no K8s

  * **aws/kubernetes** - Shell scripts para criação do ambiente Kubernetes na Amazon (EKS)

    * **aws/kubernetes/yaml** - Arquivos descritivos do kubernetes

* **dev** - Script Docker Compose para ambiente de desenvolvimento do projeto