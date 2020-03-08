# Projeto Personal ERP

## Scripts de criação de ambientes

## Descrição das pastas

* **terraform** - Todos os scripts de terraform ficarão nesta pasta, separados por ambiente.
* **terraform\prd** - Aqui ficam os scripts de incialização do ambiente de ***produção***. Irá importar os módulos que são compartilhados entre os ambientes.
* **terraform\stg** - Aqui ficam os scripts de incialização do ambiente de ***stage***. Irá importar os módulos que são compartilhados entre os ambientes.
* **terraform\modules** - Aqui ficam os módulos do projeto.
* **terraform\modules\general** - Aqui ficam os obetos comuns ao projeto como um todo (clusters, roles, etc)
* **terraform\modules\security** - Aqui ficam os objetos relativos ao módulo ***security*** do projeto.