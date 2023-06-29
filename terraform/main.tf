terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region = "sa-east-1"
  
  access_key                  = "fake"
  secret_key                  = "fake"
  
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    dynamodb = "http://localhost:4566"
    lambda   = "http://localhost:4566"
    kinesis  = "http://localhost:4566"
    sqs      = "http://localhost:4566"
    ssm      = "http://localhost:4566"
    secretsmanager = "http://localhost:4566"
  }

}


locals{
  tags = {
    Aplicacao = "minha-aplicacao.net",
    ResponsavelTecnico = "Leonardo Breda"
  }
}


###################################################
# Systems Manager > Parameter Store
###################################################
module "parameter-usuario-dev" {
  source      = "./modules/parameter-store"
  nome        = "usuario"
  descricao   = "nome do usuário pra autenticar na API"
  valor       = "joao"
  ambiente    = "DEV"
  tags = local.tags
}

module "parameter-usuario-hom" {
  source      = "./modules/parameter-store"
  nome        = "usuario"
  descricao   = "Nome do usuário pra autenticar na API"
  valor       = "maria"
  ambiente    = "HOM"
  tags = local.tags
}
module "parameter-usuario-prod" {
  source      = "./modules/parameter-store"
  nome        = "usuario"
  descricao   = "Nome do usuário pra autenticar na API"
  valor       = "manoel"
  ambiente    = "PROD"
  tags = local.tags
}

###################################################
# Secrets
###################################################
module "secret-senha-dev" {
  source      = "./modules/secrets"
  nome        = "SENHA"
  descricao   = "Senha do usuário pra autenticar na API"
  ambiente    = "DEV"
  tags = local.tags
}

module "secret-senha-hom" {
  source      = "./modules/secrets"
  nome        = "SENHA"
  descricao   = "Senha do usuário pra autenticar na API"
  ambiente    = "HOM"
  tags = local.tags
}

###################################################
# Secrets (random password)
###################################################
module "secret-random-dev" {
  source      = "./modules/secrets-random"
  nome        = "NOVO_SECRET"
  descricao   = "Segredo criado com valor randômico"
  ambiente    = "DEV"
  tags = local.tags
}


###################################################
# SQS
###################################################
module "sqs-dev" {
  source      = "./modules/sqs"
  nome        = "MEU_SQS"
  descricao   = "SQS pra cuidar de minhas mensagens"
  ambiente    = "DEV"
  delay_segundos      = 30
  retencao_minutos    = 60
  tamanho_maximo_mensagem = 256
  tags = local.tags
}