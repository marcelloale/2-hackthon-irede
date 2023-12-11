# 2º Hackhathon IT Talent

# Desafio

O desafio proposto consiste no provisionamento de uma instância Elastic Compute Cloud (EC2) da AWS por meio do Terraform. O código Terraform deve incorporar todas as configurações essenciais para implantar um servidor na AWS que esteja publicamente acessível pelo seu endereço DNS, garantindo que todas as configurações necessárias sejam realizadas automaticamente durante o processo de provisionamento. O código Terraform deve abranger desde a criação da instância EC2, security group, credenciais SSH, assegurando que o servidor resultante esteja pronto para utilização sem a necessidade de ações manuais. 

Adicionalmente, a execução desse projeto será gerenciada por meio do GitHub Actions, sendo configurada como parte de uma pipeline automatizada. Ao acionar a execução da pipeline através do git, todo o processo mencionado acima será realizado de forma automática, proporcionando uma solução eficiente e integrada. 

[Documentação Terraform de Apoio Para 2º Hackhaton](https://developer.hashicorp.com/terraform/tutorials/automation/github-actions).
