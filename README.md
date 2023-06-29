# terraform-modules
Criando artefatos na AWS via Terraform Modules

Como isso é possível? Através do LocalStack: uma ferramenta capaz de simular a maioria dos componentes AWS (Parameter Store, SQS, Secrets, etc).

No vídeo a seguir, explico a instalação de uma stack no Linux, composto por Docker, LocalStack, AWSCLI e provisionando a infra usando Terraform.

https://www.youtube.com/watch?v=c-bYqrQF98Y

[![Simulando um ambiente da AWS local](https://img.youtube.com/vi/c-bYqrQF98Y/0.jpg)](https://www.youtube.com/watch?v=c-bYqrQF98Y)

---

## Instalando Docker
```
wget https://raw.githubusercontent.com/leobreda/docker-localstack-terraform/main/instalando-docker.sh
cat instalando-docker.sh
chmod +x instalando-docker.sh
./instalando-docker.sh
```

## Instalando Localstack
```
wget https://raw.githubusercontent.com/leobreda/docker-localstack-terraform/main/instalando-localstack.sh
cat instalando-localstack.sh
chmod +x instalando-localstack.sh
./instalando-localstack.sh
```


## Instalando e executando via Docker Compose
```
wget https://raw.githubusercontent.com/leobreda/docker-localstack-terraform/main/docker-compose/localstack.yml
cat localstack.yml
docker-compose -f localstack.yml up
``` 

Rodando em segundo plano:
```
nohup docker-compose -f localstack.yml up > localstack.log &
```

Testando se o localstack está funcionando:
```
curl -v http://127.0.0.1:4566
```

## Instalando AWSCLI
```
wget https://raw.githubusercontent.com/leobreda/docker-localstack-terraform/main/instalando-awscli.sh
cat instalando-awscli.sh
chmod +x instalando-awscli.sh
./instalando-awscli.sh
```

Configurando AWSCLI
```
aws configure
AWS Access Key ID [None]: fake
AWS Secret Access Key [None]: fake
Default region name [None]: sa-east-1
Default output format [None]:
```

##  Terraform
Instalando:

```
wget https://raw.githubusercontent.com/leobreda/docker-localstack-terraform/main/instalando-terraform.sh
chmod +x instalando-terraform.sh
./instalando-terraform.sh
```

Criando objetos no Localstack via Terraform:
```
cd terraform
terraform init
terraform plan
terraform apply
```

---

## Listando objetos criados

### Parameter Store
Listar parameters
```
aws --endpoint-url=http://localhost:4566 ssm describe-parameters
```

Detalhar parameter
```
aws --endpoint-url=http://localhost:4566 ssm get-parameters --name "/dev/usuario"
```

Listar TAGs do parameter "/dev/usuario"
```
aws --endpoint-url=http://localhost:4566 ssm list-tags-for-resource --resource-type "Parameter" --resource-id "/dev/usuario"
``` 

### Simplificando o uso de LocalStack

Eliminando o uso de "--endpoint-url=http://localhost:4566"
```
alias aws='aws --endpoint-url=http://localhost:4566'
alias aws
aws ssm describe-parameters
``` 

Se quiser voltar ao que era antes...
```
alias aws='aws'
alias aws
```


### Secrets
Listar Secrets
```
aws secretsmanager list-secrets
```

Detalhar secret
```
aws secretsmanager describe-secret --secret-id "DEV/SENHA"
```

Setup de valores nas secrets
```
aws secretsmanager put-secret-value --secret-id "DEV/SENHA" --secret-string "qwert"

aws secretsmanager put-secret-value --secret-id "HOM/SENHA" --secret-string "asdfg"

```

Recuperar valor da secret
```
aws secretsmanager get-secret-value --secret-id "DEV/SENHA"

aws secretsmanager get-secret-value --secret-id "HOM/SENHA"

// Este secret não fizemos o setup, pois o valor foi gerado no módulo secrets-random
aws secretsmanager get-secret-value --secret-id "DEV/NOVO_SECRET"
```

### SQS
Listando tópicos:
```
aws sqs list-queues
```

Listas TAGs do tópico "DEV_MEU_SQS"
```
aws sqs list-queue-tags --queue-url http://localhost:4566/000000000000/DEV_MEU_SQS
```

Inserindo mensagens no tópico "DEV_MEU_SQS"
```
aws sqs send-message --queue-url http://localhost:4566/000000000000/DEV_MEU_SQS --message-body "Lorem Ipsum"

aws sqs send-message --queue-url http://localhost:4566/000000000000/DEV_MEU_SQS --message-body "Samet Dolor"

```

Lendo mensagens no tópico "DEV_MEU_SQS"
```
aws sqs receive-message --queue-url http://localhost:4566/000000000000/DEV_MEU_SQS
```

## Limpando o ambiente
Comente os recursos no arquivo main.tf 
```
//instale o editor VIM
apt-get install vim

//edite o arquivo main.tf
vim main.tf
```
Tecle "s" para editar o arquivo.
Ao finalizar a edição, tecle ESC, e depois, ":" pra acessar o prompt de comando, e "x" pra salvar e sair.

Pra ver o arquivo editado:
```
cat main.tf
```

Reprocesse o arquivo no Terraform:
```
terraform plan
terraform apply
```

Validando recursos apagados:
```
aws ssm describe-parameters
aws secretsmanager list-secrets
aws sqs list-queues
```